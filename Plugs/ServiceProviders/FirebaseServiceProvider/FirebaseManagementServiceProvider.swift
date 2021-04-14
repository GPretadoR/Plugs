//
//  FirebaseManagementProvider.swift
//  Plugs
//
//  Created by Garnik Ghazaryan on 6/28/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Firebase
import ReactiveSwift

class FirebaseManagementServiceProvider {
    
    private let db: Firestore
    private var ref: DocumentReference?
    
    init() {
        FirebaseApp.configure()
        db = Firestore.firestore()
    }
    
    func getData(from collection: String) -> SignalProducer<[[String: Any]], Error> {
        return SignalProducer { [weak self] (observer, lifetime) in
            self?.db.collection(collection).getDocuments { (querySnapshot, error) in
                if let error = error {
                    observer.send(error: error)
                } else {
                    guard let snapshot = querySnapshot else {
                        observer.sendCompleted()
                        return
                    }
                    let data: [[String: Any]] = snapshot.documents.compactMap({ $0.data() })
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                    observer.send(value: data)
                    observer.sendCompleted()
                }
            }
        }
    }
    
    func addData(to collection: String, with document: String, fields: [String: Any]) -> SignalProducer<String, Error> {
        return SignalProducer { [weak self] (observer, lifetime) in
            self?.ref = self?.db.collection(collection).addDocument(data: fields, completion: { [weak self] error in
                if let error = error {
                    observer.send(error: error)
                } else {
                    if let documentId = self?.ref?.documentID {
                        observer.send(value: documentId)
                        observer.sendCompleted()
                    } else {
                        observer.sendInterrupted()
                    }
                }
            })
        }
    }
}
