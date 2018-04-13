//
//  CMPolygonStyle.swift
//  CercaliaSDK
//
//  Created by David Comas on 26/5/17.
//
//

import UIKit

/**
 * <p>The style of polygon.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso:
 * - [CMStyling](./CMStyling.html)
 * - [CMFeatureStyle](./CMFeatureStyle.html)
 * - [CMMultiPointStyle](./CMMultiPointStyle.html)
 */
public class CMPolygonStyle : CMMultiPointStyle {
    
    public override init() {
        super.init()
        super.style = .polygons
    }
}
