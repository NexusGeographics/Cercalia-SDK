//
//  CMMultiPointStyle.swift
//  CercaliaSDK
//
//  Created by David Comas on 26/5/17.
//
//

import UIKit

/**
 * <p>The style of multipoint geometry.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso:
 * - [CMStyling](./CMStyling.html)
 * - [CMFeatureStyle](./CMFeatureStyle.html)
 * - [CMLineStyle](./CMLineStyle.html)
 * - [CMPolygonStyle](./CMPolygonStyle.html)
 */
public class CMMultiPointStyle : CMFeatureStyle {
    
    /**
     The width in pixels string. Default is 5px
     
     ## Example: ##
     ````
     CMMultiPointStyle.width = "5px"
     ````
     
     */
    public var width: String
    {
        get
        {
            return get(key: "width", defaultPixels: "5px")
        }
        
        set (value)
        {
            set(key: "width", pixels: value)
        }
    }
    
    public override init() {
        super.init()
        self.width = "5px"
    }
}
