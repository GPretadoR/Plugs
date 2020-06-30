//
//  DatabaseServiceProvider.swift
//  RakutenShop
//
//  Created by Garnik Ghazaryan on 2/18/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import CoreData
import ReactiveSwift

class DatabaseServiceProvider: DatabaseServices {
    typealias T = DatabaseTask
    typealias Output = NSManagedObject
    typealias Input = Any
    
    let persistentContainerName: String
    
    init(persistentContainerName: String) {
        self.persistentContainerName = persistentContainerName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistentContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    func syncSaveUnique(entityName: String,
                        uniqueKeyValue: [String: String]) {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            guard let key = uniqueKeyValue.keys.first, let value = uniqueKeyValue[key] else { return }
            fetchRequest.predicate = NSPredicate(format: "\(key) = %@", value)
            
            let fetchResult = try context.fetch(fetchRequest)
            if fetchResult.count == 0 {
                saveContext()
            }
        } catch {
            print("error")
        }
    }
    
    func performUnique(entityName: String,
                       uniqueKeyValue: [String: String],
                       completion: @escaping (NSManagedObjectContext) throws -> Void) -> SignalProducer<Bool, Error> {
        return SignalProducer { [weak self] (observer, lifetime) in
            self?.context.perform { [weak self] in
                do {
                    guard let weakself = self else { return }
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    guard let key = uniqueKeyValue.keys.first, let value = uniqueKeyValue[key] else {
                        observer.sendInterrupted()
                        return
                    }
                    fetchRequest.predicate = NSPredicate(format: "\(key) = %@", value)
                    
                    let fetchResult = try weakself.context.fetch(fetchRequest)                    
                    if fetchResult.count == 0 {
                        weakself.saveContext()
                        _ = try completion(weakself.context)
                        observer.send(value: true)
                        observer.sendCompleted()
                    }
                    observer.sendCompleted()
                } catch {
                    observer.send(error: error)
                    print("error")
                }
            }
        }
    }
    
    func perform(completion: @escaping (NSManagedObjectContext) throws -> Void) -> SignalProducer<Bool, Error> {
        return SignalProducer { [weak self] (observer, _) in
            self?.context.perform { [weak self] in
                do {
                    guard let weakself = self else { return }
                    _ = try completion(weakself.context)
                    weakself.saveContext()
                    observer.send(value: true)
                    observer.sendCompleted()
                } catch {
                    observer.send(error: error)
                    print("error")
                }
            }
        }
    }
    
    func fetch<Output>(objectType: Output.Type) -> SignalProducer<[Output], Error> {
        return SignalProducer { [weak self] (observer, _) in
            let entityName = String(describing: objectType)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            do {
                let result = try self?.context.fetch(fetchRequest) as? [Output]
                observer.send(value: result ?? [Output]())
                observer.sendCompleted()
            } catch {
                observer.send(error: error)
            }
        }
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
