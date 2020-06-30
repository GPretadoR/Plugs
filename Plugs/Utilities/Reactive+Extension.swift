//
//  Reactive+Extension.swift
//  Velvioo
//
//  Created by Garnik Ghazaryan on 3/28/20.
//  Copyright © 2020 Garnik Ghazaryan. All rights reserved.
//

import Foundation
import ReactiveSwift
import ReactiveCocoa

extension KeyboardChangeContext {
    
    func inset(of view: UIView, coveredView: UIView, isDismissing: Bool) {
        let intersection = coveredView.frame.intersection(endFrame)
        if !intersection.isNull {
            var viewRect = view.frame
            viewRect = CGRect(origin: CGPoint(x: viewRect.origin.x, y: -intersection.height), size: viewRect.size)
            view.frame = viewRect
        } else if isDismissing {
            view.frame.origin = .zero
        }
    }
    
    var isDismissing: Bool {
        return UIScreen.main.bounds.intersection(endFrame).height == 0
    }
    
}

extension Reactive where Base: UIApplication {
    public static var didEnterBackground: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.didEnterBackgroundNotification).map(value: ())
    }
    public static var willEnterForeground: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.willEnterForegroundNotification).map(value: ())
    }
    public static var didFinishLaunching: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.didFinishLaunchingNotification).map(value: ())
    }
    public static var didBecomeActive: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.didBecomeActiveNotification).map(value: ())
    }
    public static var willResignActive: Signal<(), Never> {
        return NotificationCenter.default.reactive
            .notifications(forName: UIApplication.willResignActiveNotification).map(value: ())
    }
}
