//
//  CMLog.swift
//  CercaliaSDK
//

import Foundation

class CMLog {
    
    //Log TAGS
    private let iTag = "I/"
    private let dTag = "D/"
    private let wTag = "W/"
    private let eTag = "E/"
    
    
    let classTag: String;
    
    init(_ classTag: String) {
        self.classTag = classTag
    }
    
    public func d(tag: String, info: String){
        if CMCercalia.instance.debugLogger {
            print(dTag + classTag + " [" + tag + "] " + info )
        }
    }
    
    public func i(tag: String, info: String){
        if CMCercalia.instance.infoLogger {
            print(iTag + classTag + " [" + tag + "] " + info )
        }
    }
    
    public func w(tag: String, info: String){
        print(wTag + classTag + " [" + tag + "] " + info )
    }
    
    public func e(tag: String, info: String){
        print(eTag + classTag + " [" + tag + "] " + info )
    }
}
