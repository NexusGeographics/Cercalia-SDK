//
//  CMFontStyle.swift
//  CercaliaSDK
//
//  Created by David Comas on 26/5/17.
//
//


import UIKit

/**
 * <p>The font label style.
 * Customize text font.</p>
 * <p/>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso: [CMLabelStyle](./CMLabelStyle.html)
 */
public class CMFontStyle : JSONable {

    /// The enum Weight.
    public enum Weight : String {
        
        /// Lighter Weight
        case lighter = "lighter"
        
        /// Normal Weight
        case normal = "normal"
        
        /// Bold Weight
        case bold = "bold"
        
        /// Bolder Weight
        case bolder = "bolder"
    }
    
    
    /// The enum Transform.
    public enum Transform : String {
        
        /// Capitalize Transform
        case capitalize = "capitalize"
        
        /// Uppercase Transform
        case uppercase = "uppercase"
        
        /// Lowercase Transform
        case lowercase = "lowercase"
    }
    
    /// The enum text Style.
    public enum Style : String {
        
        /// Italic text Style
        case italic = "italic"
    }

    /// The font-family of the label. Default is **Helvetica**.
    public var family : String?
    {
        get
        {
            return get(key: "family") as? String
        }
        set(value)
        {
            set(key: "family", value: value)
        }
    }
    
    /**
     The text size in pixels.
     
     ## Example: ##
     ````
     CMFontStyle.size = "16px"
     ````
     */
    public var size : String?
    {
        get
        {
            return get(key: "size") as? String
        }
        set(value)
        {
            set(key: "size", value: value)
        }
    }
    
    /// The text Style. Currently supports only `italic`.
    public var style : Style?
    {
        get
        {
            return get(key: "style") as? Style
        }
        set(value)
        {
            set(key: "style", value: value)
        }
    }
    
    /// The text weight
    public var weight : Weight?
    {
        get
        {
            return get(key: "weight") as? Weight
        }
        set(value)
        {
            set(key: "weight", value: value)
        }
    }
    
    /**
     The text color filled.
     
     ## Example: ##
     ````
     CMFontStyle.fill = "#ff0000"
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
    public var fill : String?
    {
        get
        {
            return get(key: "fill") as? String
        }
        set(value)
        {
            set(key: "fill", value: value)
        }
    }
    
    /// The stroke color and width of the label.
    public var stroke : CMStroke?
    {
        get
        {
            let json = get(key: "stroke", defaultJSONable: CMStroke())
            let stroke = json != nil ? CMStroke(jsonsable: json) : nil
            stroke?.parent = self
            stroke?.key = "stroke"
            return stroke
        }
        set(value)
        {
            set(key: "stroke", value: value)
        }
    }
    
    /// Text transform style
    public var transform : Transform?
    {
        get
        {
            return get(key: "transform") as? Transform
        }
        set(value)
        {
            set(key: "transform", value: value)
        }
    }
    
    public override init() {
        super.init()
        self.defaultInit()
    }
    
    public override init(jsonsable: JSONable?) {
        super.init(jsonsable: jsonsable)
    }
    
    public override init(dictionary: Dictionary<String, Any>) {
        super.init(dictionary: dictionary)
    }
    
    private func defaultInit() {
        self.family = "Helvetica"
        self.size = "12px"
        self.weight = .normal
        self.fill = "#252525"
        self.stroke = CMStroke(color: "#4C4C4C", width: "0.8px")
    }
}

/// Defines color and width
public class CMStroke : JSONable {
    
    /**
     The text color filled. Default is **white**.
     
     ## Example: ##
     ````
     CMStroke.color = "#ff0000"
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
    public var color: String?
    {
        get
        {
            return get(key: "color") as? String
        }
        set(value)
        {
            set(key: "color", value: value)
        }
    }
    
    /**
     The width in pixels string. Default is **1px**.
     
     ## Example: ##
     ````
     CMStroke.width = "5px"
     ````
     
     */
    public var width: String?
    {
        get
        {
            return get(key: "width") as? String
        }
        set(value)
        {
            set(key: "width", pixels: value)
        }
    }
    
    public override init(){
        super.init()
        self.color = "white"
        self.width = "1px"
    }
    
    public init(color: String?, width: String?){
        super.init()
        self.color = color
        self.width = width
    }
    
    public override init(jsonsable: JSONable?) {
        super.init(jsonsable: jsonsable)
    }
    
    public override init(dictionary: Dictionary<String, Any>) {
        super.init(dictionary: dictionary)
    }
}

