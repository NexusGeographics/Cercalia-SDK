//
//  CMCircle.swift
//  CercaliaSDK
//
//  Created by Marc on 27/6/17.
//
//

import UIKit
import TangramMap

public class CMCircle : CMGeometry {
    private var radius:Double = 0.0;
    private var center:CMLatLng = CMLatLng(0,0);
    
    private var coordinates:Array<CMLatLng>? = [];
    private var definition:Int = 40;
    
    /// The point style
    public var style: CMCircleStyle?
    {
        get
        {
            return self.style_ as? CMCircleStyle
        }
        
        set(value)
        {
            self.style_ = value
        }
    }
    
    // MARK: public methods
    public override init(name: String) {
        super.init(name: name);
    }
    
    public convenience init(name: String, center: CMLatLng, radius: Double) {
        self.init(name: name)
        self.center = center;
        self.radius = radius;
        self.style_ = CMCircleStyle();
        self.calculatePoints();
    }
    
    internal override func create(layer: CMLayer) -> Bool {
        let success = super.create(layer: layer)
        if !success { return false }
        
        return self.updateCoordinates();
    }
    
    private func calculatePoints() {
        var center:Array<Double> = self.center.toMercator();
        
        let partition = 360 / self.definition;
        
        for i in 0 ..< self.definition {
            let radiants = (2 * Double.pi * Double(partition * i)) / 360.0;
            
            let lat = center[0] + (radius * sin(radiants)); // 02.0000
            let lng = center[1] + (radius * cos(radiants)); // 41.0000
            
            let latLng = CMLatLng.fromMercator(lat: lat, lng: lng);
            if(latLng != nil){
                coordinates?.append(latLng!);
            }
        }
    }
    
    public func getRadius() -> Double {
        return radius;
    }
    
    public func setRadius(radius: Double) {
        self.radius = radius;
        self.calculatePoints();
        _ = self.updateCoordinates();
    }
    
    public func getCenter() -> CMLatLng {
        return self.center;
    }
    
    public func setCenter(center: CMLatLng) {
        self.center = center;
        self.calculatePoints();
        _ = self.updateCoordinates();
    }
    
    public func getDefinition() -> Int {
        return self.definition;
    }
    
    public func setDefinition(definition: Int) {
        self.definition = definition;
        self.calculatePoints();
        _ = self.updateCoordinates();
    }
    
    internal func updateCoordinates() -> Bool {
        if self.isCreated() {
            if self.coordinates != nil  && self.coordinates!.count > 2 {
                super.feature?.polygon = CMUtils.convert(toGeoPolygon: coordinates!)
                return true
            }else{
                CMLog("CMCircle").w(tag: "create()", info: "CMCircle should contain 3 or more coordinates")
                return false
            }
        }
        return false
    }
    
    /*private func transformToTangramCoordinates(coordinates: Array<CMLatLng>) -> Array<TGGeoPoint> {
        var lngLatList = Array<TGGeoPoint>();
        for latLng in coordinates {
            lngLatList.append(latLng);
        }
        
        return lngLatList;
    }*/
}
