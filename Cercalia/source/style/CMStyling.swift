//
//  CMStyling.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/5/17.
//
//

import UIKit

/**
 * <p>The basic style.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso:
 * - [CMLabelStyle](./CMLabelStyle.html)
 * - [CMMarkerStyle](./CMMarkerStyle.html)
 * - [CMLineStyle](./CMLineStyle.html)
 * - [CMPolygonStyle](./CMPolygonStyle.html)
 */
public class CMStyling : JSONable {

    /// The enum Style.
    public enum Style : String {
        /// The Polygon Style
        case polygons = "polygons"
        
        /// The Polyline Style
        case lines = "lines"
        
        /// The Point & Marker Style
        case points = "points"
        
        /// The Label Style
        case text = "text"
    }
    
    /// The Type of Style
    public var style : Style
    {
        get
        {
            return get(key: "style", defaultStyle: .points)
        }
        
        set (value)
        {
            set(key: "style", value: value)
        }
    }
    
    /// A point or text draw group marked with `collide: false` will not be checked for any collisions
    public var collide: Bool
    {
        get
        {
            return get(key: "collide", defaultBool: false)
        }
        
        set (value)
        {
            set(key: "collide", value: value)
        }
    }
    
    
    /// Optional boolean. Default is true. If false, features will not be drawn.
    public var visible: Bool
    {
        get
        {
            return get(key: "visible", defaultBool: true)
        }
        
        set (value)
        {
            set(key: "visible", value: value)
        }
    }
    
    /**
    Specifies the vertex color of the feature. This color will be passed to any active shaders and used in any light calculations as “color”.
 
     ## Example: ##
     ````
     Styling.setColor("#ff0000")
     ````
     
     ## Color format: ##
     ````
     Named colors:  red, blue, salmon, rebeccapurple
     Hex colors: "#fff", "#000", "#9CE6E5" 
     RGB colors: "rgb(255, 190, 0)" 
     RGBA colors**: "rgb(255, 190, 0, .5)" 
     HSL colors: "hsl(180, 100%, 100%)" 
     HSL colors**: "hsla(180, 100%, 100%, 50%)"
     ````
     
     **Currently, alpha values are ignored in the add and multiply blend modes, and respected in the inlay and overlay modes. For more on this, see the blend entry.
     */
    public var color: String
    {
        get
        {
            return get(key: "color", defaultString: "white")
        }
        
        set (value)
        {
            set(key: "color", value: value)
        }
    }
    
    public override init() {
        super.init()
        
        self.style = .points
        self.visible = true
        self.collide = false
        self.color = "white"
    }
    
    //private final transient Map<String, String> mapStyle;
    public override init(dictionary: Dictionary<String, Any>) {
        super.init(dictionary: dictionary)
    }
    
    public override init(jsonsable: JSONable?) {
        super.init(jsonsable: jsonsable)
    }
  
}
