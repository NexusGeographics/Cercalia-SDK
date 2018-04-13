//
//  MapController.swift
//  CercaliaSDK
//
//  Created by David Comas on 25/4/17.
//
//

import UIKit
import TangramMap
import CoreLocation

/// The map controller delegate
@objc public protocol CMMapControllerDelegate: NSObjectProtocol {
    
    /**
     The map ready callback
     
     - Parameter map: The map controller
     */
    @objc optional func onReadyMap(_ map: CMMapController)
    
    /**
     On user click map callback
     
     - Parameter map: The map controller
     - Parameter location: The click location
     */
    @objc optional func map(_ map: CMMapController, onClick location: CMLatLng)
    
    /**
     On user double-click map callback
     
     - Parameter map: The map controller
     - Parameter location: The double-click location
     */
    @objc optional func map(_ map: CMMapController, onDoubleClick location: CMLatLng)
    
    /**
     On user long-click map callback
     
     - Parameter map: The map controller
     - Parameter location: The long-click location
     */
    @objc optional func map(_ map: CMMapController, onLongClick location: CMLatLng)
    
    /**
     On user pan map callback
     
     - Parameter map: The map controller
     - Parameter displacement: The pan displacement point
     */
    @objc optional func map(_ map: CMMapController, onPan displacement: CGPoint)
    
    /**
     On user pinch map callback
     
     - Parameter map: The map controller
     - Parameter location: The pinch location
     */
    @objc optional func map(_ map: CMMapController, onPinch location: CMLatLng)
    
    /**
     On user pinch map callback
     
     - Parameter map: The map controller
     - Parameter rotation: The ratation in radiants
     */
    @objc optional func map(_ map: CMMapController, onRotation ration: Float)
    
    /**
     On user shove map callback
     
     - Parameter map: The map controller
     - Parameter displacement: The shove point
     */
    @objc optional func map(_ map: CMMapController, onShove displacement: CGPoint)
    
    /**
     On user select marker callback
     
     - Parameter map: The map controller
     - Parameter feature: The marker feature selected
     */
    @objc optional func map(_ map: CMMapController, didSelectMarker feature: CMMarker)
    
    /**
     On user select feature callback
     
     - Parameter map: The map controller
     - Parameter feature: The feature selected
     */
    @objc optional func map(_ map: CMMapController, didSelectGeometry feature: CMGeometry)
}



/**
 Map controller.
 
 ### Usage example: ###
 
 ````
 let mapView: CMMapView = ...;
 let mapController = CMMapController.instance(mapView)
 mapController?.create();
 
 ````
 */
public class CMMapController : NSObject, TGMapViewDelegate, CLLocationManagerDelegate {
    
    private let ANIMATE_DEFAULT_DURATION: Float = 0.5
    
    //Log
    internal let log: CMLog = CMLog("MapController")
    
    var mapView: CMMapView
    
    /// map controller delegate, see `CMMapControllerDelegate`
    public var delegate: CMMapControllerDelegate?
    
    //Layers
    /// Private layer, user can't modify
    private var layerPrivate: CMLayer?
    
    /// default map layer
    private var mapLayer: CMLayer?
    
    /// Array of layers added using CMMapController.put(layer: CMLayer)
    private var layers: Set<CMLayer>
    
    //Map Markers
    /// My location marker (added in privateLayer)
    private var myLocationMarker: CMMarker?
    
    
    // UI Settings
    /// UISettings for user
    public let settings: CMUISettings
    
    //MyLocation
    /// Location manager
    private var locationManager = CLLocationManager()
    
    /// Last user locatio (container)
    private var myLocation_: CMLatLng?
    /// Last user location, nil if myLocationEnabled is `false`
    public var myLocation: CMLatLng?
    {
        get
        {
            return self.myLocationEnabled ? myLocation_ : nil
        }
    }
    
    /// myLocationEnabled (container)
    private var myLocationEnabled_: Bool = false
    /// My location enbale, True to enable MyLocation
    public var myLocationEnabled: Bool
    {
        get
        {
            return myLocationEnabled_
        }
        set (value)
        {
            myLocationEnabled_ = value
            self.updateMyLocationState()
        }
    }
    
    
    private init(_ map: CMMapView) {
        self.mapView = map
        self.layers = Set<CMLayer>()
        self.settings = CMUISettings()
        super.init()
    }
    
    /**
     Instanciante new MapController
     */
    public static func instance(_ mapView: CMMapView) -> CMMapController {
        return CMMapController(mapView)
    }
    
    /**
     Create a mapView
     */
    public func create(){
        self.mapView.create()
        
        self.settings.map = self
        
        self.mapView.map?.gestureDelegate = self
        self.mapView.map?.mapViewDelegate = self
        
        // Posem la scene de cercalia (TODO)
        let sceneURL = Bundle(for: CMMapController.self).path(forResource: "scene-cercalia", ofType: "yaml") // "scene-cercalia.yaml"
        self.loadSceneFile(scene: sceneURL!)
        
        self.layerPrivate = CMLayer(name: "private_map_layer", mapController: self, isBaseLayer: true)
        
        self.mapLayer = CMLayer(name: "map_layer", mapController: self, isBaseLayer: true)
    }
    
    
    //MARK: Public
    
    // SECENE
    
    /**
     Load scene file
     
     - Parameter scene: the scene path URL
     */
    public func loadSceneFile(scene: String) {
        self.mapView.loadSceneFileAsync(scene: scene)
    }
    
    /**
     Loads a scene asynchronously, with a list of updates to be applied to the scene.
     If a scene update error happens, scene updates won't be applied.
     
     - Parameter scene: the scene path URL
     - Parameter keyPath: the key path
     - Parameter newValue: new value
     */
    public func loadSceneFile(scene: String, keyPath: String, keyValue: String) {
        self.mapView.loadSceneFileAsync(scene: scene, keyPath: keyPath, newValue: keyValue)
    }
    
    // CAMERA
    
    /**
        Update map camera according CameraUpdate. Animates the movement of the camera.
     
     - Parameter cameraUpdate: The change that should be applied to the camera.
     */
    public func animateCamera(cameraUpdate: CMCameraUpdate) {
        self.animateCamera(cameraUpdate: cameraUpdate, duration: ANIMATE_DEFAULT_DURATION)
    }
    
    /**
     Update map camera according CameraUpdate. Animates the movement of the camera.
     
     - Parameter cameraUpdate: The change that should be applied to the camera.
     - Parameter duration: Time in seconds to ease to the given position
     */
    public func animateCamera(cameraUpdate: CMCameraUpdate, duration: Float){
        
        if cameraUpdate.position != nil {
            self.mapView.map?.animate(toPosition: CMUtils.convert(toGeoPoint: cameraUpdate.position!),
                                      withDuration: duration)
        }
        
        if cameraUpdate.zoom != nil {
            self.mapView.map?.animate(toZoomLevel: cameraUpdate.zoom!,
                                      withDuration: duration)
        }
        
        if cameraUpdate.rotation != nil {
            self.mapView.map?.animate(toRotation: cameraUpdate.rotation!,
                                      withDuration: duration)
        }
        
        if cameraUpdate.deltaZoom != nil {
            self.mapView.map?.animate(toZoomLevel: (self.mapView.map!.zoom + cameraUpdate.deltaZoom!),
                                      withDuration: duration)
        }
        
        if cameraUpdate.tilt != nil {
            self.mapView.map?.animate(toTilt: cameraUpdate.tilt!,
                                      withDuration: duration)
        }
        
        if cameraUpdate.bounds != nil {
            self.mapView.map?.animate(toPosition: CMUtils.convert(toGeoPoint: cameraUpdate.bounds!.getCenter()!), withDuration: duration);
            self.mapView.map?.animate(toZoomLevel: CMUtils.calculateZoom(mapController: self, bounds: cameraUpdate.bounds!, paddingPx: cameraUpdate.paddingPx),
                                      withDuration: duration);
            self.mapView.map?.animate(toRotation: 0.0, withDuration: duration);
        }
        
    }
    
    
    /**
     Update map camera according CameraUpdate.
     
     - Parameter cameraUpdate: The change that should be applied to the camera.
     */
    public func moveCamera(cameraUpdate: CMCameraUpdate) {
        animateCamera(cameraUpdate: cameraUpdate, duration: 0)
    }
    
    /**
     Update map camera according CameraUpdate.
     
     - Returns: Current camera state.
     */
    public func getCameraPosition() -> CMCameraPosition {
        
        return CMCameraPosition(position: CMLatLng(point: self.mapView.map!.position),
                                zoom: self.mapView.map!.zoom,
                                rotation: self.mapView.map!.rotation,
                                tilt: self.mapView.map!.tilt)
    }
    
    // MARK: Features & Layers
    
    /**
     Remove all features and layers.
    */
    public func clear() {
        
        //Eliminem els markers
        _ = self.removeAllMarkers()
        
        //Eliminem el layers
        self.layers.removeAll()
    }
    
    /**
     Gets feature layer
     
     - Returns: All map layers
     */
    public func getLayers() -> Set<CMLayer> {
        // Fem una copia de la llista
        var arr = Set<CMLayer>()
        if self.mapLayer != nil {arr.insert(self.mapLayer!)}
        
        for l in self.layers {
            arr.insert(l)
        }
        
        return arr
    }
    
    /**
     Put feature
     
     - Parameter feature: Feature to add
     - Returns: True: success, False: fails
     */
    public func put(feature: CMFeature) -> Bool {
        if self.mapLayer != nil {
            return self.mapLayer!.put(feature: feature)
        }
        
        return false
    }
    
    /**
     Remove feature
     
     - Parameter feature: Feature to remove
     */
    public func remove(feature: CMFeature) {
        self.mapLayer?.remove(feature: feature)
    }
    
    /**
     Remove Array of feature
     
     - Parameter feature: Array to remove
     */
    public func remove(features: Set<CMFeature>) {
        self.mapLayer?.remove(features: features)
    }
    
    
    /**
     Remove all markers
     */
    public func removeAllMarkers() {
        
        //Fem el clear del baseLayer
        self.mapLayer?.clear()
        
        //Fem clear de tots els layer
        for layer in self.layers {
            layer.clear()
        }
    }
    
    /**
     Put layer
     
     - Parameter feature: Layer to add
     - Returns: CMMapController.self
     */
    internal func put(layer: CMLayer)  {
        if !self.layers.contains(layer) {
            self.layers.insert(layer)
        }
    }
    
    /**
     Remove layer and remove markers inside layer
     
     - Parameter feature: Layer to remove
     - Returns: CMMapController.self
     */
    public func remove(layer: CMLayer) {
        if self.layers.contains(layer) {
            self.layers.remove(layer)
            layer.clear()
        }
    }
    
    
    // MARK: MyLocation
    /// Update My Location State. Called when user change `myLocationEnabled`
    private func updateMyLocationState(){
        self.updateLocationManagerState()
    }
    
    /// Start/Stop location manager
    private func updateLocationManagerState(){
        
        // Si Enable -> monitoritzem la localitzció
        // Altrament -> parem el servei de localització
        if self.myLocationEnabled {
            
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }
        }else{
            locationManager.stopUpdatingLocation()
        }
    }
    
    /// Updates MyLocation Marker. Called after `public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])`
    private func updateLocationMarker(){
        if let location = self.myLocation {
            if myLocationMarker == nil {
                
                //Creem el marker
                self.myLocationMarker = CMMarker(name: "MyLocationMarker")
                self.myLocationMarker?.coordinate = location
                self.myLocationMarker?.image = UIImage(contentsOfFile: Bundle(for: CMMarker.self).path(forResource: "location", ofType: "png")!)!
                let style = self.myLocationMarker!.style
                style.size = ["27px", "27px"]
                self.myLocationMarker?.style = style
                
                let success = self.layerPrivate?.put(feature: self.myLocationMarker!)
                if success == nil || !success! {
                    self.myLocationMarker = nil
                }
                
            }else {
                self.myLocationMarker?.coordinate = location
            }
            
        }else if self.myLocationMarker != nil {
            
            // Eliminem el marker
            self.layerPrivate?.remove(feature: self.myLocationMarker!)
            self.myLocationMarker = nil
        }
    }
    
    // MARK: CLLocationManagerDelegate methods
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Agafem la localització del manager.
        if manager.location != nil {
            let latlng = CMLatLng(manager.location!.coordinate.latitude,manager.location!.coordinate.longitude)
            self.myLocation_ = latlng
            updateLocationMarker() // Actualitzem el marker
        }
    }
    
    
    // MARK: TGMapViewDelegate - ViewMap protocols
    
    public func mapViewDidCompleteLoading(_ mapView: TGMapViewController) {
        log.d(tag: "GESTURE", info: "mapViewDidCompleteLoading")
    }
    
    public func mapView(_ mapView: TGMapViewController, didLoadSceneAsync scene: String) {
        log.d(tag: "GESTURE", info: "didLoadSceneAsync (" + scene + ")")
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(mapIsReady), userInfo: nil, repeats: false)
        
    }
    
    @objc func mapIsReady() {
        self.delegate?.onReadyMap?(self)
    }
    
    //////// Esta comentats perque no funcionen
    //public func mapView(_ mapView: TGMapViewController, didSelectFeature feature: [String : String]?, atScreenPosition position: CGPoint) {
    //}
    //
    //public func mapView(_ mapView: TGMapViewController, didSelectLabel labelPickResult: TGLabelPickResult?, atScreenPosition position: CGPoint) {
    //}
    
    public func mapView(_ mapView: TGMapViewController, didSelectMarker markerPickResult: TGMarkerPickResult?, atScreenPosition position: CGPoint) {
        
        if markerPickResult != nil && markerPickResult?.marker != nil {
            log.d(tag: "GESTURE", info: "didSelectMarker markerPickResult")
            
            let feature = self.getFeatureBy(marker: markerPickResult!.marker)
            
            if feature != nil && (feature as? CMLabel) != nil {
                
            }else if feature != nil && (feature as? CMMarker) != nil {
                self.delegate?.map?(self, didSelectMarker: feature as! CMMarker)
            }else if feature != nil && (feature as? CMGeometry) != nil {
                self.delegate?.map?(self, didSelectGeometry: feature as! CMGeometry)
            }
        }
    }
    
    /**
     Find cercalia feature using tangram marker
     
     - Paramter marker: Tangram marker
     - Returns: Cercalia feature if exist
     */
    private func getFeatureBy(marker: TGMarker) -> CMFeature? {
        var feature: CMFeature? = nil
        for layer in self.getLayers() {
            feature = layer.getFeatureBy(marker: marker)
            if feature != nil {
                break
            }
        }
        return feature
    }
    
}
