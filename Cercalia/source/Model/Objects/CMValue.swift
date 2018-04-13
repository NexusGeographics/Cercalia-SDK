//
//  CMValue.swift
//  CercaliaSDK
//
//  Created by Marc on 14/6/17.
//
//

import UIKit

/**
 * Copyright (c) 2017 Nexusgeographics All rights reserved.
 *
 * Cercalia json class with a field: value
 */
public class CMValue: CMObject {
    var value:Any?;
    
    override init(dic: NSDictionary) {
        super.init(dic: dic);
    }
    
    /**
     * Instantiates a new Value.
     *
     * parameter value: the value
     */
    convenience init (value: Any?){
        self.init(dic: NSDictionary());
        self.value = value;
    }
    
    /**
     * Gets value.
     *
     * - returns: the value
     */
    public func getValue() -> Any? {
        return self.value;
    }
    
    /**
     * Sets value.
     *
     * @param value the value
     */
    public func setValue(value: Any) {
        self.value = value;
    }
}

