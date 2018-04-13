//
//  CMCircleStyle.swift
//  CercaliaSDK
//
//  Created by Marc on 28/6/17.
//
//

import UIKit

/**
 * <p>The style of circle geometry.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso:
 * - [CMStyling](./CMStyling.html)
 * - [CMFeatureStyle](./CMFeatureStyle.html)
 * - [CMMultiPointStyle](./CMMultiPointStyle.html)
 * - [CMPolygonStyle](./CMPolygonStyle.html)
 */
public class CMCircleStyle : CMMultiPointStyle {
    
    /**
     The width in pixels string. Default is 5px
     
     ## Example: ##
     ````
     CMCircleStyle.width = "5px"
     ````
     
     */
    
    public override init() {
        super.init()
        self.defaultInit();
    }
    
    private func defaultInit(){
        super.style = .lines;
    }
}

