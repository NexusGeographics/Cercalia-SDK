//
//  CMFeatureStyle.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/5/17.
//
//

import UIKit

/**
 * <p>The Feature style.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso:
 * - [CMStyling](./CMStyling.html)
 * - [CMLineStyle](./CMLineStyle.html)
 * - [CMPolygonStyle](./CMPolygonStyle.html)
 * - [CMMarkerStyle](./CMMarkerStyle.html)
 * - [CMPointStyle](./CMPointStyle.html)
 */
public class CMFeatureStyle : CMStyling {
    
    /// When true, activates Feature Selection, allowing this drawing of the feature. Default is **false**.
    public var interactive : Bool
    {
        get
        {
            return get(key: "interactive", defaultBool: true)
        }
        
        set (value)
        {
            set(key: "interactive", value: value)
        }
    }
    
    ///Sets the drawing order of the draw style, to be used in case of z-depth collisions (when two features are at the same “z” height in space). In this case, higher-ordered layers will be drawn over lower-ordered layers. Child layer settings override parent layer settings. Default is **100**.
    public var order: NSNumber
    {
        get
        {
            return get(key: "order", defaultNumber: 100)
        }
        
        set (value)
        {
            set(key: "order", value: value)
        }
    }
    
    public override init() {
        super.init()

        self.interactive = true
        self.order = 100
    }
    
}
