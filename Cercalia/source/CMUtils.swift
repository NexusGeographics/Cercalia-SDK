//
//  Utils.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/4/17.
//
//

import UIKit
import TangramMap

/**
 *
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 */
public class CMUtils {

    internal static func convert(toGeoPoint position: CMLatLng) -> TGGeoPoint {
        return TGGeoPoint(longitude: position.lng, latitude: position.lat)
    }
    
    internal static func convert(toGeoPolyline coordinates: [CMLatLng]) -> TGGeoPolyline {
        let line = TGGeoPolyline()
        
        for c in coordinates {
            line.add(self.convert(toGeoPoint: c))
        }
        
        return line
    }
    
    internal static func convert(toGeoPolygon coordinates: [CMLatLng]) -> TGGeoPolygon {
        let polygon = TGGeoPolygon()
        polygon.startPath(self.convert(toGeoPoint: coordinates[0]), withSize: UInt32(coordinates.count))
        
        for i in 1  ..< coordinates.count  {
            let c = coordinates[i]
            polygon.add(self.convert(toGeoPoint: c))
        }
        
        return polygon
    }
    
    internal static func image(_ aClass: Swift.AnyClass, resource: String) -> UIImage? {
        return self.image(aClass, resource: resource, ofType: "png")
    }
    
    internal static func image(_ aClass: Swift.AnyClass, resource: String, ofType: String) -> UIImage? {
        return UIImage(contentsOfFile: Bundle(for: aClass).path(forResource: resource, ofType: ofType)!)
    }
    
    /**
     * Array to string separated string.
     *
     * - parameter array:       the array
     * - parameter separatedBy: the separated by string
     * - returns: the string
     */
    internal static func arrayToStringSeparated(array: Array<String>?, separatedBy: String) -> String {
        var strRet = "";
        if(array != nil && (array?.count)! > 0){
            for element:String in array! {
                strRet += element + separatedBy;
            }
            
            let index = strRet.index(strRet.startIndex, offsetBy: strRet.characters.count - separatedBy.characters.count);
            strRet = strRet.substring(to: index);
        }
        
        return strRet;
    }
    
    internal static func calculateZoom(mapController: CMMapController, bounds: CMLatLngBounds, paddingPx: Int) -> Float {
        let pixelsMetresByZoom = CMUtils.calcPixelsMetersByZoom(mapController: mapController);
        
        let w = mapController.mapView.frame.size.width;
        let h = mapController.mapView.frame.size.height;
        
        let boundsNorthWest = CMLatLng(bounds.northeast.lat, bounds.southwest.lng);
        let boundsCenter = bounds.getCenter();
        
        if boundsCenter == nil {
            return 20.0;
        }
        
        let boundsTopCenter = CMLatLng(boundsNorthWest.lat, (boundsCenter?.lng)!);
        let boundsLeftCenter = CMLatLng((boundsCenter?.lat)!, boundsNorthWest.lng);
        let distanceBoundsY = boundsTopCenter.distance(latLng: boundsCenter) * 2;
        let distanceBoundsX = boundsLeftCenter.distance(latLng: boundsCenter) * 2;
        
        let zoomX = abs(log2((Double(Int(w) - paddingPx) * pixelsMetresByZoom) / distanceBoundsX));
        let zoomY = abs(log2((Double(Int(h) - paddingPx) * pixelsMetresByZoom) / distanceBoundsY));
        
        let zoom = zoomX < zoomY ? zoomX : zoomY;
        
        return Float(zoom > 20 ? 20.0 : zoom < 1 ? 1.0 : zoom);
    }
    
    internal static var maxResolution: Double?;
    internal static var maxResolutionZoom: Float?;
    
    internal static func calcPixelsMetersByZoom(mapController: CMMapController) -> Double {
        if CMUtils.maxResolution == nil || Double(CMUtils.maxResolutionZoom!) < Double(mapController.getCameraPosition().zoom) {
            let w = Double(mapController.mapView.frame.size.width);
            
            let topLeftCorner_ = mapController.mapView.map?.screenPosition(toLngLat: CGPoint(x: 0, y: 0));
            let topRightCorner_ = mapController.mapView.map?.screenPosition(toLngLat: CGPoint(x: w, y: 0));
            let topLeftCorner = CMLatLng((topLeftCorner_?.latitude)!, (topLeftCorner_?.longitude)!);
            let topRightCorner = CMLatLng((topRightCorner_?.latitude)!, (topRightCorner_?.longitude)!);
            
            let dist = topLeftCorner.distance(latLng: topRightCorner);
            let r = (dist / w) * Double(pow(2, mapController.getCameraPosition().getZoom()));
            print("CalcBounds r: " + String(r));
            CMUtils.maxResolution = r;
            CMUtils.maxResolutionZoom = mapController.getCameraPosition().getZoom();
            return r;
        }
        else {
            return CMUtils.maxResolution!;
        }
    }
}
