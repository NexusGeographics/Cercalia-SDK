//
//  CMPolygon.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/5/17.
//
//

import UIKit
import TangramMap

/**
 Polygon feature.
 The Polygon draws filled polygon with three or more coordinates, the first and last coordinate can't be the same.
 
 ### Usage example: ###
 
 ````
 let mapController: CMMapController = ...
 let coordinates: [CMLatLng] = ...
 
 let polygon = CMPolygon(name: "My Polygon")
 polygon.coordinates = coordinates
 
 mapController.put(feature: polygon)
 ````
 
 */
public class CMPolygon : CMMultiPoint {
    
    /// The polygon style.
    public var style: CMPolygonStyle
    {
        get
        {
            return self.style_ as! CMPolygonStyle
        }
        
        set(value)
        {
            self.style_ = value
        }
    }
    
    // MARK: public methods
    
    public override init(name: String) {
        super.init(name: name)
        self.style = CMPolygonStyle()
    }
    
    internal override func create(layer: CMLayer)  -> Bool {
        let success = super.create(layer: layer);
        if !success { return false }
        
        return true;
    }
    
    // MARK: internal methods
    
    /// Update coordinates if feature is created.
    override internal func updateCoordinates() -> Bool {
        if self.isCreated() {
            if coordinates != nil  && coordinates!.count > 2 {
                super.feature?.polygon = CMUtils.convert(toGeoPolygon: coordinates!)
                return true
            }else{
                CMLog("CMPolygon").w(tag: "create()", info: "CMLine should contain 3 or more coordinates")
                return false
            }
        }
        return false
    }
}
