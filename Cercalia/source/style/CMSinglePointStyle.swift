//
//  CMSinglePointStyle.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/5/17.
//
//

import UIKit

/**
 * <p>The style of single point geometry.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso:
 * - [CMStyling](./CMStyling.html)
 * - [CMFeatureStyle](./CMFeatureStyle.html)
 * - [CMLabelStyle](./CMLabelStyle.html)
 * - [CMMarkerStyle](./CMMarkerStyle.html)
 */
public class CMSinglePointStyle : CMFeatureStyle {
    
    /// The Label Style
    public var text : CMLabelStyle?
    {
        get
        {
            let json = self.get(key: "text", defaultJSONable: nil)
            let label = json != nil ? CMLabelStyle(jsonsable: json) : nil
            label?.parent = self
            label?.key = "text"
            return label
        }
        
        set(value)
        {
            self.set(key: "text", value: value)
        }
    }
    
    /**
     The Size of content.
     
     ## Example: ##
     ````
     SinglePointStyle.size = ["25px", "25px"]
     ````
     */
    public var size: [String]
    {
        get
        {
            return get(key: "size", defaultPixelsArray: ["35px", "35px"])
        }
        
        set (value)
        {
            set(key: "size", pixelsArray: value)
        }
    }
    
    /**
     Moves the feature from its original location.
     
     ## Example: ##
     ````
     SinglePointStyle.offset = ["25px", "25px"]
     ````
     */
    public var offset: [String]
    {
        get
        {
            return get(key: "offset", defaultPixelsArray: ["0px", "0px"])
        }
        
        set (value)
        {
            set(key: "offset", pixelsArray: value)
        }
    }
    
    public override init() {
        super.init()
        self.size = ["35px", "35px"]
        self.offset = ["0px", "0px"]
    }
    
    public func setText(text: String){
        if self.text == nil {
            self.text = CMLabelStyle(text: text)
        }
        
        self.text?.textSource = text // CMTextSource(text: text)
    }
    
}
