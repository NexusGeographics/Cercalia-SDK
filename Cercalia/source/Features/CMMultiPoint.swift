//
//  CMMultiPoint.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/5/17.
//
//

import UIKit
import TangramMap

public class CMMultiPoint : CMGeometry {
    
    private var coordinates_: [CMLatLng]?
    /// The coordinates
    public var coordinates: [CMLatLng]?{
        get
        {
            return coordinates_
        }
        set (value)
        {
            coordinates_ = value
            _ = self.updateCoordinates()
        }
    }
    
    // MARK: public methods
    
    public override init(name: String) {
        super.init(name: name)
    }
    
    internal override func create(layer: CMLayer) -> Bool {
        let success = super.create(layer: layer)
        if !success { return false }
        
        return self.updateCoordinates()
    }
    
    /// This method should override and don't called `super.updateCoordinates()`
    internal func updateCoordinates() -> Bool{
        print("Function NO overrided")
        return false
    }
}
