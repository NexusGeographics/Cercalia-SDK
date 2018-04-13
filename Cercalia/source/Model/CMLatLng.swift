//
//  LatLng.swift
//  CercaliaSDK
//

import UIKit
import TangramMap

public class CMLatLng: NSObject {

    public let lat: Double
    public let lng: Double
    
    /// LatLng to string
    public var string : String
    {
        get{
            return String(lat) + ", " + String(lng)
        }
    }
    
    /**
     LatLng Constructor
     
     - Parameter lat: Coordinate latitude
     - Parameter lng: Coordinate longitude
     */
    public init(_ lat: Double,_ lng: Double) {
        self.lat = lat
        self.lng = lng
    }

    /**
     LatLng Constructor
     
     - Parameter point: The point
     */
    internal convenience init(point:  TGGeoPoint) {
        self.init(point.latitude, point.longitude)
    }
    
    /**
     LatLng Constructor
     
     - Parameter map: The map controller
     - Parameter point: The point
     */
    internal convenience init(_ map: CMMapController, point: CGPoint) {
        if map.mapView.map != nil {
            self.init(point: map.mapView.map!.screenPosition(toLngLat: point))
        }else{
            self.init(0, 0);
        }
    }
    
    /**
     *
     * - parameter latLng: other coordinate
     * - returns: distance in meters
     */
    public func distance(latLng:CMLatLng?) -> Double {
        if(latLng == nil){
            return 0.0;
        }
        
        let R = 6371e3; // metres
        
        let φ1 = GLKMathDegreesToRadians(Float(self.lat));
        let φ2 = GLKMathDegreesToRadians(Float(latLng!.lat));
        let Δφ = GLKMathDegreesToRadians(Float(latLng!.lat-self.lat));
        let Δλ = GLKMathDegreesToRadians(Float(latLng!.lng-self.lng));
        
        let a = sin(Δφ/2) * sin(Δφ/2) +
            cos(φ1) * cos(φ2) *
            sin(Δλ/2) * sin(Δλ/2);
        let c = 2 * atan2(sqrt(a), sqrt(1-a));
        
        return R * Double(c);
    }
   
    /**
     * Transfors coordinates to mercator
     * - returns: array [y, x]
     */
    public func toMercator() -> Array<Double> {
        let r_major = Float(6378137.000);
        let lng = r_major * GLKMathDegreesToRadians(Float(self.lng));
        let scale = lng/Float(self.lng);
        let lat = Float(180.0/Double.pi) * log(tan(Float(Double.pi/4.0) + Float(self.lat) * Float(Double.pi/180.0)/2.0)) * scale;
        
        return [Double(lat), Double(lng)];
    }
    
    /**
     * Transform coordinates mercator to geographics
     * - parameter lat: mercator latitude
     * - parameter lng: mercator latitude
     * - returns: coordinate converted
     */
    public static func fromMercator(lat: Double, lng: Double) -> CMLatLng? {
        if (abs(lng) < 180 && abs(lat) < 90) {
            return nil;
        }
        
        if ((abs(lng) > 20037508.3427892) || (abs(lat) > 20037508.3427892)){
            return nil;
        }
        
        let x = lng;
        let y = lat;
        let num3 = x / 6378137.0;
        let num4 = num3 * 57.295779513082323;
        let num5 = floor(((num4 + 180.0) / 360.0));
        let num6 = num4 - (num5 * 360.0);
        let num7 = 1.5707963267948966 - (2.0 * atan(exp((-1.0 * y) / 6378137.0)));
        
        return CMLatLng(num7 * 57.295779513082323, num6);
    }
    
    // MARK: internal methods
    
    /// Convert object to TGeoPoint
    internal func convert() -> TGGeoPoint {
        return CMUtils.convert(toGeoPoint: self);
    }
}
