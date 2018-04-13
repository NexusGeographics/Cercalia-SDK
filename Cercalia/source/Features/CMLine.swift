//
//  CMLine.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/5/17.
//
//

import UIKit
import TangramMap

/**
 Line feature.
 The Line draws lines with two or more coordinates.
 
 ### Usage example: ###
 
 ````
 let mapController: CMMapController = ...
 let coordinates: [CMLatLng] = ...
 
 let line = CMLine(name: "My Line")
 line.coordinates = coordinates
 
 mapController.put(feature: line)
 ````
 
 */
public class CMLine : CMMultiPoint {
    
    /// The line style
    public var style: CMLineStyle
    {
        get
        {
            return self.style_ as! CMLineStyle
        }
        
        set(value)
        {
            self.style_ = value
        }
    }
    
    // MARK: public methods
    
    public override init(name: String) {
        super.init(name: name)
        self.style = CMLineStyle()
    }
    
    // MARK: internal methods
    
    internal override func create(layer: CMLayer) -> Bool {
        let success = super.create(layer: layer)
        if !success { return false }
        
        return true
    }
    
    override internal func updateCoordinates() -> Bool {
        if self.isCreated() {
            if coordinates != nil  && coordinates!.count > 1 {
                super.feature?.polyline = CMUtils.convert(toGeoPolyline: coordinates!)
                return true
            }else{
                CMLog("CMLine").w(tag: "create()", info: "CMLine should contain 2 or more coordinates")
                return false
            }
        }
        return false
    }
}
