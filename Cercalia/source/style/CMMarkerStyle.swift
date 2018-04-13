//
//  CMMarkerStyle.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/5/17.
//
//

import UIKit

/**
 * <p>The style of Marker.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso:
 * - [CMStyling](./CMStyling.html)
 * - [CMFeatureStyle](./CMFeatureStyle.html)
 * - [CMSinglePointStyle](./CMSinglePointStyle.html)
 */
public class CMMarkerStyle : CMSinglePointStyle {

    
    required public override init() {
        super.init();
        self.defaultInit()
    }
    
    private func defaultInit() {
        super.style = .points;
        super.size = ["35px", "35px"];
        super.order = 1000;
        super.collide = false;
    }
    
}
