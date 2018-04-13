//
//  CMLabelStyle.swift
//  CercaliaSDK
//
//  Created by David Comas on 26/5/17.
//
//

import UIKit

/**
 * <p>The style of Label.</p>
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * - SeeAlso: [CMStyling](./CMStyling.html)
 */
public class CMLabelStyle : CMStyling {
    
    /// The enum Anchor.
    public enum Anchor : String {
        /// Center anchor
        case center = "center"
        
        /// Left anchor
        case left = "left"
        
        /// Right anchor
        case right = "right"
        
        /// Top anchor
        case top = "top"
        
        /// Bottom anchor
        case bottom = "bottom"
    }
    
    /// Font Style
    public var font : CMFontStyle
    {
        get
        {
            let json = get(key: "font", defaultJSONable: CMFontStyle())
            let font = CMFontStyle(jsonsable: json)
            font.parent = self
            font.key = "font"
            return font
        }
        set(value)
        {
            set(key: "font", value: value)
        }
    }
    
    /// Always false.
    private var interactive : Bool
    {
        get
        {
            return get(key: "interactive", defaultBool: false)
        }
        set(value)
        {
            set(key: "interactive", value: value)
        }
    }
    
    /**
     Moves the label from its original location. Default ["0px", "0px"]
     
     ## Example: ##
     ````
     CMLabelStyle.offset = ["25px", "25px"]
     ````
     */
    public var offset : [String]
    {
        get
        {
            return get(key: "offset", defaultPixelsArray: ["0px", "0px"])
        }
        set(value)
        {
            set(key: "offset", value: value)
        }
    }
   
    private var textSourcePrefix: String = "function() { return '"
    private var textSourcePostfix: String = "'; }"
    
    /// Text of Label
    public var textSource: String
    {
        get
        {
            var text = get(key: "text_source", defaultString: "");
            text = text.replacingCharacters(in: text.range(of: textSourcePrefix)!, with: "")
            text = text.replacingCharacters(in: text.range(of: textSourcePostfix)!, with: "")
            return text
        }
        set(value)
        {
            set(key: "text_source", value: textSourcePrefix + value + textSourcePostfix)
        }
    }
    
    /// Label text aling. String one of left, center, right. Default is center
    public var align: String?
    {
        get
        {
            return get(key: "align") as? String
        }
        set(value)
        {
            set(key: "align", value: value)
        }
    }
    
    /// The anchor
    public var anchor : Anchor?
    {
        get
        {
            return get(key: "anchor") as? Anchor
        }
        set(value)
        {
            set(key: "anchor", value: value)
        }
    }
    
    /// The text wrap.  Default is **15**.
    public var textWrap: String?
    {
        get
        {
            return get(key: "text_wrap") as? String
        }
        set(value)
        {
            set(key: "text_wrap", value: value)
        }
    }
    
    /// Specifies minimum distance between labels in the same repeat_group, measuring from the center of each label. Default is **256px**.
    public var repeatDistance: String?
    {
        get
        {
            return get(key: "repeat_distance") as? String
        }
        set(value)
        {
            set(key: "repeat_distance", value: value)
        }
    }
    
    /// Allows the grouping of different label types for purposes of fine-tuning label repetition. 
    public var repeatGroup: String?
    {
        get
        {
            return get(key: "repeat_group") as? String
        }
        set(value)
        {
            set(key: "repeat_group", value: value)
        }
    }
    
    /// The label priority of the feature.
    public var priority: NSNumber?
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
    public var sprite: String?
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
    public var outline: String?
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
    
    public init(text: String) {
        super.init()
        self.textSource = text;
        self.defaultInit()
    }
    
    public override init(dictionary: Dictionary<String, Any>) {
        super.init(dictionary: dictionary)
    }
    
    public override init(jsonsable: JSONable?) {
        super.init(jsonsable: jsonsable)
    }
    
    private func defaultInit() {
        super.style = .text
        super.collide = false
        
        self.font = CMFontStyle()
        self.anchor = .top
        self.interactive = false
        self.offset = ["0px","0px"]
    }
}
