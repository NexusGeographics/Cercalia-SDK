//
//  CMLabel.swift
//  CercaliaSDK
//
//  Created by David Comas on 29/5/17.
//
//

import UIKit
import TangramMap

/**
 Polygon feature.
 The Label draws text label at a given point.
 
 ### Usage example: ###
 
 ````
 let mapController: CMMapController = ...
 let coordinate: CMLatLng = ...
 
 let label = CMLabel(text: "My label")
 label.coordinate = coordinate
 
 mapController.put(feature: label)
 ````
 
 */
public class CMLabel : CMFeature {
    
    /// The label text
    public var text: String {
        get
        {
            return style.textSource
        }
        set (value)
        {
            self.style.textSource = value
        }
    }
    
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
    
    /// The label style
    public var style: CMLabelStyle
    
    // MARK: public methods
    
    public init(text: String) {
        self.style = CMLabelStyle(text: text)
        super.init(name: text)
        self.text = text
    }
    
    internal override func create(layer: CMLayer) -> Bool {
        let success = super.create(layer: layer)
        if !success { return false }
        
        feature?.stylingString = style.toJson();
        return updateCoordinate()
    }
    
    // MARK: private methods
    
    /// update cordinate if feature is created
    private func updateCoordinate() -> Bool {
        if self.isCreated() {
            if coordinate != nil  {
                super.feature?.point = coordinate!.convert()
                return true
            }else{
                CMLog("CMLabel").w(tag: "create()", info: "coordinate is necessary")
                return false
            }
        }
        return false
    }
}
