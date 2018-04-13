//
//  CMKeyValue.swift
//  CercaliaSDK
//
//  Created by Marc on 14/6/17.
//
//

import UIKit

/**
 * Copyright (c) 2017 Nexusgeographics All rights reserved.
 *
 * Cercalia json class with two fields: id and value
 */
public class CMKeyValue: CMObject {
    var id: Any?;
    var value:Any?;
    
    override init(dic: NSDictionary) {
        super.init(dic: dic);
    }

    /**
     * Instantiates a new Key value.
     *
     * - parameter id:    the id
     * - parameter value: the value
     */
    convenience init(id: Any?, value: Any?){
        self.init(dic: NSDictionary());
        
        self.id = id;
        self.value = value;
    }
    
    /**
     * Gets id.
     *
     * - returns: the id
     */
    public func getId() -> Any? {
        return self.id;
    }
    
    /**
     * Gets value.
     *
     * - returns: the value
     */
    public func getValue() -> Any? {
        return self.value;
    }
}
