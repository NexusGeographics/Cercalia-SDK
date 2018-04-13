//
//  CMPointStyle.swift
//  CercaliaSDK
//
//  Created by David Comas on 26/5/17.
//
//

import UIKit

/**
 * <p>The style of Point.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso:
 * - [CMStyling](./CMStyling.html)
 * - [CMFeatureStyle](./CMFeatureStyle.html)
 * - [CMSinglePointStyle](./CMSinglePointStyle.html)
 */
public class CMPointStyle : CMSinglePointStyle {
    
    /**
     Optional string, one of vertex, spaced, midpoint, or centroid. Default is **vertex**.
     
     Applies to points styles. Defines the placement method of one or more points, when a points-based style is used to draw line or polygon features.

     */
    public var placement : String?
    {
        get
        {
            return get(key: "placement") as? String
        }
        set(value)
        {
            set(key: "placement", value: value)
        }
    }
    
    /**
     Specifies the minimum line segment length as a ratio to the size (greater of width or height) of the point being placed. This prevents points from being drawn on line segments which are smaller than the point itself. Default is **1**.
     */
    public var placementMinLengthRatio : NSNumber?
    {
        get
        {
            return get(key: "placement_min_length_ratio") as? NSNumber
        }
        set(value)
        {
            set(key: "placement_min_length_ratio", value: value)
        }
    }
    
    /// The Placement Spacing. Default is **80px**.
    public var placementSpacing : String?
    {
        get
        {
            return get(key: "placement_spacing") as? String
        }
        set(value)
        {
            set(key: "placement_spacing", value: value)
        }
    }
    
    /// The label priority of the feature.
    public var priority : NSNumber?
    {
        get
        {
            return get(key: "priority") as? NSNumber
        }
        set(value)
        {
            set(key: "priority", value: value)
        }
    }
    
    /// The sprite to be used when drawing a feature
    public var sprite : String?
    {
        get
        {
            return get(key: "sprite") as? String
        }
        set(value)
        {
            set(key: "sprite", value: value)
        }
    }
    
    /// Draws an outline around the feature.
    public var outline : String?
    {
        get
        {
            return get(key: "outline") as? String
        }
        set(value)
        {
            set(key: "outline", value: value)
        }
    }
    
    
    required public override init() {
        super.init();
        self.defaultInit()
    }
    
    private func defaultInit() {
        super.style = .points;
        super.size = ["25px", "25px"];
        super.order = 997;
        super.collide = false;
    }
    
}
