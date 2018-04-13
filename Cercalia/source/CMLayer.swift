//
//  Layer.swift
//  CercaliaSDK
//

import UIKit
import TangramMap


/**
 * The Layer Delegate.
 */
@objc public protocol CMLayerDelegate: NSObjectProtocol {
    /**
     * Called when feature is removed.
     *
     * @param feature the feature
     */
    @objc optional func layer(_ layer: CMLayer, onRemoved feature: CMFeature);
}

/**
 *
 * <p>Feature layer.</p>
 * <p>Usage example: </p>
 *
 * <pre><code>
 * // Create layer
 * MapController map = ...;
 * let layer = CMLayer(name: "my_layer", mapController: map, isBaseLayer: true)
 *
 * // Add feature
 * Marker marker = ...;
 * let success = layer.put(feature: marker)
 * </pre></code>
 *
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 *
 */
public class CMLayer: NSObject, CMRemoveObserver {
    
    /// Array of features
    private var features: Set<CMFeature>
    
    /// Layer name
    public var name: String
    
    /// The map controller
    internal var mapController: CMMapController
    
    /// Is base layer
    public var isBaseLayer: Bool
    
    /// The layer delegate
    public var delegate: CMLayerDelegate?
    
    
    public init(name: String, mapController: CMMapController, isBaseLayer: Bool ) {
        self.features = Set<CMFeature>()
        self.name = name
        self.mapController = mapController
        self.isBaseLayer = isBaseLayer
        super.init()
        
        // Posem el layer al mapa
        _ = self.mapController.put(layer: self)
    }
    
    public convenience init(name: String, mapController: CMMapController) {
        self.init(name: name, mapController: mapController, isBaseLayer: false)
    }
    
    //MARK: CMRemoveObserver
    
    public func onRemoved(observable: CMRemoveObservable) {
        observable.remove(observer: self)// treiem el delegate

         if let feature = observable as? CMFeature {
            self.features.remove(feature)
            self.delegate?.layer?(self, onRemoved: feature)
        }
    }
    
    
    //MARK: Public methods
    
    /**
     Remove all features
     */
    public func clear() {
        _ = self.remove(features: features)
    }
    
    /**
     Check if layer contains feature
     
     - Parameter feature: Feature to check
     - Returns: True if layer contains feature, otherwise false
     */
    public func contains(feature: CMFeature) -> Bool {
        return features.contains(feature)
    }
    
    /**
     Gets all layer features
     
     - Returns: All features
     */
    public func getFeatures() -> Set<CMFeature> {
        var array = Set<CMFeature>();
        for f in features { array.insert(f) }
        return array
    }
    
    /**
     Put feature
     
     - Parameter feature: Feature to add
     - Returns: True: success, False: fails
     */
    public func put(feature: CMFeature) -> Bool {
        if(!feature.isCreated()){
            let success = feature.create(layer: self)
            
            if success {
                self.features.insert(feature)
                feature.add(observer: self)
            }
            
            return success;
        }
        
        return false
    }
    
    /**
     Put features
     
     - Parameter features: Array feature to add
     - Returns: True: success, False: fails
     */
    public func put(features: Set<CMFeature>) -> Bool {
        var success = true
        for f in features {
            success = self.put(feature: f) && success
        }
        return success
    }
    
    /**
     Remove features
     
     - Parameter features: Array features to remove
     */
    public func remove(features: Set<CMFeature>) {
        for f in features {
            _ = self.remove(feature: f)
        }
    }
    
    /**
     Remove feature
     
     - Parameter feature: Feature to remove
     */
    public func remove(feature: CMFeature) {
        feature.remove()
    }
    
    //MARK: Internal methods
    
    /**
     Find cercalia feature using tangram marker
     
     - Paramter marker: Tangram marker
     C
     */
    internal func getFeatureBy(marker: TGMarker) -> CMFeature? {
        
        for feature in self.features {
            if self.compare(tMarker: marker, feature: feature) {
                return feature
            }
        }
        
        return nil
    }
    
    /// Compare Tangram marker and Cercalia feature
    private func compare(tMarker: TGMarker, feature: CMFeature) -> Bool {
        return feature.isCreated() ? feature.feature == tMarker : false;
    }
}
