//
//   CMLatLngBounds.swift
//  CercaliaSDK
//
//  Created by Marc on 29/6/17.
//
//

import UIKit
import TangramMap
import MapKit

/**
 * The type Lat lng bounds.
 */
public class CMLatLngBounds: NSObject {
    
    // Northeast corner of the bound.
    public let northeast: CMLatLng
    
    // Southwest corner of the bound.
    public let southwest: CMLatLng

    /**
     * Instantiates a new Lat lng bounds.
     *
     * - parameter northeast: the northeast
     * - parameter southwest: the southwest
     */
    init(northeast: CMLatLng, southwest: CMLatLng) {
        self.northeast = northeast;
        self.southwest = southwest;
    }
    
    /**
     * Get center.
     *
     * - returns: the lat lng
     */
    public func getCenter() -> CMLatLng? {
        let northeastMercator = self.northeast.toMercator();
        let southwestMercator = self.southwest.toMercator();
        
        let x = southwestMercator[1] + ((northeastMercator[1] - southwestMercator[1]) / 2);
        let y = southwestMercator[0] + ((northeastMercator[0] - southwestMercator[0]) / 2);
        
        return CMLatLng.fromMercator(lat: y, lng: x);
    }
    
    /**
     * Include lat lng bounds.
     *
     * - parameter point: to be included in the new bounds
     * - returns: A new LatLngBounds that contains this and the extra point.
     */
    public func include(point: CMLatLng) -> CMLatLngBounds? {
        return Builder()
            .include(point: self.northeast)
            .include(point: self.southwest)
            .include(point: point)
            .build();
    }
    
    /**
     * The type Builder.
     */
    public class Builder: NSObject {
        /**
         * The List.
         */
        var list = Array<CMLatLng>();
        
        /**
         * Include builder.
         *
         * - parameter point: the point
         * - returns: the builder
         */
        public func include(point: CMLatLng) -> Builder {
            list.append(point);
            return self;
        }
        
        /**
         * Build lat lng bounds.
         *
         * - returns: the lat lng bounds
         */
        public func build() -> CMLatLngBounds? {
            if (self.list.count == 0){
                return nil;
            }
            else if (self.list.count == 1){
                return CMLatLngBounds(northeast: self.list[0], southwest: self.list[0]);
            }
            else if (self.list.count == 2){
                let line = MKPolyline(coordinates: self.getCoordinatesList(list: self.list), count: self.list.count);
                return self.build(mapRect: line.boundingMapRect);
            }
            else if (self.list.count > 2){
                let polygon = MKPolygon(coordinates: self.getCoordinatesList(list: self.list), count: self.list.count);
                return self.build(mapRect: polygon.boundingMapRect);
            }
            
            return nil;
        }
        
        public func build(mapRect: MKMapRect) -> CMLatLngBounds? {
            let northeastY = mapRect.origin.y + mapRect.size.height;
            let northeastX = mapRect.origin.x + mapRect.size.width;
            
            let northeast = CMLatLng(MKCoordinateForMapPoint(MKMapPoint(x: mapRect.origin.x, y: northeastY)).latitude,MKCoordinateForMapPoint(MKMapPoint(x: northeastX, y: mapRect.origin.y)).longitude);
            let southwest = CMLatLng(MKCoordinateForMapPoint(mapRect.origin).latitude, MKCoordinateForMapPoint(mapRect.origin).longitude);

            
            return CMLatLngBounds(northeast: northeast, southwest: southwest);
        }
        
        private func getCoordinatesList(list : Array<CMLatLng>) -> Array<CLLocationCoordinate2D> {
            var coordinates = Array<CLLocationCoordinate2D>();
            
            for coord: CMLatLng in list {
                coordinates.append(CLLocationCoordinate2DMake(coord.lat, coord.lng));
            }
            
            return coordinates;
        }
    }
}
