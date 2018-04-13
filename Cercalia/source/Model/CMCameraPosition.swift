//
//  CameraPosition.swift
//  CercaliaSDK
//

import UIKit

public class CMCameraPosition {

    /// The map center position
    let position: CMLatLng
    
    /// The map zoom
    let zoom: Float
    
    /// The rotation map
    let rotation: Float
    
    /// The tilt map
    let tilt: Float
    
    /**
     * Instantiates a new Camera position.
     *
     * - parameter position: the geographic position of the center of the map view
     * - parameter zoom:     the zoom level of the map view
     * - parameter rotation: the rotation of the view
     * - parameter tilt:     the tilt angle of the view
     */
    init(position: CMLatLng, zoom: Float, rotation: Float, tilt: Float) {
        self.position = position
        self.zoom = zoom
        self.rotation = rotation
        self.tilt = tilt
    }
    
    /**
     * Gets position.
     *
     * - returns: the position
     */
    public func getPosition() -> CMLatLng {
        return self.position;
    }
    
    /**
     * Gets zoom.
     *
     * - returns: the zoom
     */
    public func getZoom() -> Float {
        return self.zoom;
    }
    
    /**
     * Gets rotation.
     *
     * - returns: the rotation
     */
    public func getRotation() -> Float {
        return self.rotation;
    }
    
    /**
     * Gets tilt.
     *
     * - returns: the tilt
     */
    public func getTilt() -> Float {
        return self.tilt;
    }
}
