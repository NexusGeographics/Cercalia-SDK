//
//  Point.swift
//  CercaliaSDK
//
//  Created by David Comas on 24/5/17.
//
//

import UIKit
import TangramMap


/**
 Point feature. 
 The Point draws a filled circle at given point.  
 
 ### Usage example: ###
 
 ````
 let mapController: CMMapController = ...
 let coordinate: CMLatLng = ...
 
 let style = CMPointStyle()
 style.size = ["30px", "30px"]
 style.color = "red"
 style.outline = "30px"
 
 let point = CMPoint(name: "My Point") 
 point.style = style
 point.coordinate = coordinate
 
 mapController.put(feature: point)
 ````
 
 */
public class CMPoint : CMGeometry {
    
    private var coordinate_: CMLatLng?
    /// The coordinate
    public var coordinate: CMLatLng? {
        get
        {
            return coordinate_
        }
        
        set (value)
        {
            coordinate_ = value
            _ = self.updateCoordinate()
        }
    }
    
    /// The point style
    public var style: CMPointStyle?
    {
        get
        {
            return self.style_ as? CMPointStyle
        }
        
        set(value)
        {
            self.style_ = value
        }
    }
    
    // MARK: public methods
    
    public override init(name: String) {
        super.init(name: name)
        self.style = CMPointStyle()
    }
    
    
    // MARK: internal methods
    
    internal override func create(layer: CMLayer) -> Bool {
        let success = super.create(layer: layer)
        if !success { return false }

        return self.updateCoordinate()
    }
    
    
    // MARK: private methods
    
    private func updateCoordinate() -> Bool {
        if self.isCreated() {
            if coordinate != nil  {
                super.feature?.point = coordinate!.convert()
                return true
            }else{
                CMLog("CMPoint").w(tag: "create()", info: "coordinate is necessary")
                return false
            }
        }
        return false
    }
}
