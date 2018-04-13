//
//  CMMarker.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/5/17.
//
//

import UIKit
import TangramMap

/**
 Marker feature.
 The Marker draws icon at given point
 
 ### Usage example: ###
 
 ````
 let mapController: CMMapController = ...
 let coordinate: CMLatLng = ...
 
 let marker = CMMarker(name: "My Marker")
 marker.coordinate = coordinate
 
 mapController.put(feature: marker)
 ````
 
 */
public class CMMarker : CMFeature {
    
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
    
    
    public var image_ : UIImage
    /// The marker image
    public var image : UIImage {
        get
        {
            return image_
        }
        set(value)
        {
            image_ = value
            DispatchQueue.main.async {
                self.updateImage()
            }
        }
    }
    
    /// The marker style
    public var style: CMMarkerStyle
    
    // MARK: public methods
    
    public override init(name: String) {
        self.style = CMMarkerStyle()
        self.image_ = CMUtils.image(CMMarker.self, resource: "marker")!
        super.init(name: name)
    }
    
    public convenience init(name: String, coordinate: CMLatLng, image: UIImage) {
        self.init(name: name)
        self.coordinate = coordinate
        self.image = image
    }
    
    public func pubUpdateImage(){
        if self.isCreated() {
            DispatchQueue.main.async {
                self.feature?.icon = self.image
            }
            
        }
    }
    
    internal override func create(layer: CMLayer) -> Bool {
        let success = super.create(layer: layer)
        if !success { return false }
        
        feature?.stylingString = style.toJson();
        
        updateImage()
        
        return updateCoordinate()
    }
    
    // MARK: private methods
    
    /// Update coordinate if marker is created
    private func updateCoordinate() -> Bool {
        
        if self.isCreated() {
            if coordinate != nil  {
                super.feature?.point = coordinate!.convert()
                return true
            }else{
                CMLog("CMMarker").w(tag: "create()", info: "coordinate is necessary")
                return false
            }
        }
        return false
    }
    
    /// Update image if marker is created
    private func updateImage() {
        
        if self.isCreated() {
            self.feature?.icon = image
        }
    }
}
