//
//  CMRemoveObservable.swift
//  CercaliaSDK
//
//  Created by David Comas on 29/5/17.
//
//

import Foundation
import UIKit

@objc public protocol CMRemoveObserver: NSObjectProtocol {
    
    /**
     Called after observable calls RemoveObservable.notifyRemoveObservers()
     
     - Parameter observable: the observable
     */
    @objc optional func onRemoved(observable: CMRemoveObservable)
}

public class CMRemoveObservable : NSObject {
    private let log: CMLog = CMLog("CMRemoveObservable")
    
    /// The Observers
    public var observers: [CMRemoveObserver] = [CMRemoveObserver]()
    
    
    /**
     Add observer.
     
     - Parameter observer: the observer
     */
    public func add(observer: CMRemoveObserver) {
        self.observers.append(observer)
    }
    
    /**
     Remove observer.
     
     - Parameter observer: the observer
     */
    public func remove(observer: CMRemoveObserver) {
        let index = getIndex(observer: observer)
        if index != nil {
            self.observers.remove(at: index!)
        }
    }
    
    /**
     Get index of observer.
     
     - Parameter observer: the observer
     - returns: Index of observer. Optional Int.
     */
    private func getIndex(observer: CMRemoveObserver) -> Int? {
    
        for i in 0...observers.count {
            if observers[i] === observer {
                return i
            }
        }
        
        return nil
    }
    
    /**
     Notify to observers.
     */
    internal func notifyRemoveObserver() {
        for observer in self.observers {
            observer.onRemoved?(observable: self)
        }
    }
}
