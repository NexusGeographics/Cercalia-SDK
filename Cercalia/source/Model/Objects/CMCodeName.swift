//
//  CMCodeName.swift
//  CercaliaSDK
//
//  Created by Marc on 13/6/17.
//
//

import UIKit

/**
 * Copyright (c) 2017 Nexusgeographics All rights reserved.
 *
 * Cercalia json class with two fields: code and name
 */
public class CMCodeName: CMObject {
    var code: Any?;
    var name:Any?;
    
    override init(dic: NSDictionary) {
        super.init(dic: dic);
    }
    
    /**
     * Instantiates a new Code name.
     *
     * - parameter code: the code
     * - parameter name: the name
     */
    convenience init(code: Any?, name: Any?){
        self.init(dic: NSDictionary());
        self.code = code;
        self.name = name;
    }
    
    /**
     * Gets code.
     *
     * - returns: the code
     */
    public func getCode() -> Any? {
        return self.code;
    }
    
    /**
     * Gets name.
     *
     * - returns: the name
     */
    public func getName() -> Any? {
        return self.name;
    }
}
