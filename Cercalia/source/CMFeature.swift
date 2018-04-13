//
//  Feature.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/4/17.
//
//

import UIKit
import TangramMap

/**
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 * The Feature child type
 *
 * - SeeAlso: 
 * - [CMPoint](./CMPoint.html)
 * - [CMLine](./CMLine.html)
 * - [CMPolygon](./CMPolygon.html)
 * - [CMMarker](./CMMarker.html)
 * - [CMLabel](./CMLabel.html)
 *
 */
public class CMFeature : CMRemoveObservable
{

    // MARK: attributes
    
    //Obligatoris
    
    /// Feature name
    private let _name : String;
    
    /// Feature name

    public var name : String {
        get { return _name}
    }
    
    /// Feature info
    public var info : Any?;
    
    // Feature
    /// Tangram marker
    internal var feature: TGMarker?
    
    /// Map Controller
    private var map : CMMapController?
    
    //Layer
    /// Layer
    internal var layer: CMLayer?
    
    public var string: String {
        get { return "[CMFeature] name: " + _name}
    }
    
    private var _id:Int
    
    // Feature id
    public var id: Int {
        get { return _id }
    }

    private static var nFeatures:Int = 0;
    
    // MARK: constructor
    
    init(name: String) {
        self._name = name;
        self._id = CMFeature.createId();
    }
    
    /**
     Create a ID for the feature
     
     - Returns: An ID for the feature
     */
    private static func createId() -> Int {
        let createdID = CMFeature.nFeatures;
        CMFeature.nFeatures += 1;
        return createdID;
    }
    
    // MARK: public methods
    
    /**
     Check if feature is created.
     
     - Returns: True if Feature is created
     */
    public func isCreated() -> Bool {
         return layer != nil && self.feature != nil
    }
    
    /// Remove feature from map
    public func remove() {
        if self.isCreated() {
            if let marker = self as? CMMarker {
                // si fem map?.markerRemove(self.feature!) amb un Marker dona error.
                marker.feature?.visible = false
            }else{
                self.layer?.mapController.mapView.map?.markerRemove(self.feature!)
            }
            
            self.feature = nil
            self.layer = nil;
            self.map = nil;
            
            self.notifyRemoveObserver()
        }
    }
    
    
    // MARK: internal methods
    
    /// Create Feature
    internal func create(layer: CMLayer) -> Bool {
        self.layer = layer
        self.map = layer.mapController
        self.feature = self.layer?.mapController.mapView.map?.markerAdd()
        
        return self.isCreated()
    }
    
}
