//
//  CMGeometry.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/5/17.
//
//

import UIKit
import TangramMap

public class CMGeometry : CMFeature {
    
    private var style__: CMStyling?
    // The Geometry Style
    internal var style_: CMStyling?
    {
        get
        {
            return self.style__
        }
        set(value)
        {
            self.style__ = value
            _ = updateStyle()
        }
    }

    // MARK: public methods
    
    public override init(name: String) {
        super.init(name: name)
    }
    
    internal override func create(layer: CMLayer) -> Bool {
        let success = super.create(layer: layer)
        if !success { return false }

        return updateStyle()
    }
    
    // MARK: private methods
    
    /// Update Style if feature is created
    private func updateStyle() -> Bool {
        if style_ != nil {
            feature?.stylingString = style_!.toJson()
            return true
        }else{
            CMLog("CMGeometry").w(tag: "addStyle", info: "style is necessary")
            return false
        }
    }
    
}
