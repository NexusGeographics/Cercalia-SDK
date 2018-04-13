//
//  CMLineStyle.swift
//  CercaliaSDK
//
//  Created by David Comas on 26/5/17.
//
//

import UIKit

/**
 * <p>The style of Line.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso:
 * - [CMStyling](./CMStyling.html)
 * - [CMFeatureStyle](./CMFeatureStyle.html)
 * - [CMMultiPointStyle](./CMMultiPointStyle.html)
 */
public class CMLineStyle : CMMultiPointStyle {
    
    /// Draws an outline around the feature.
    public var outline : String?
    {
        get
        {
            return get(key: "outline") as? String
        }
        set(value)
        {
            set(key: "outline", pixels: value)
        }
    }

    public override init() {
        super.init()
        super.style = .lines
    }
}
