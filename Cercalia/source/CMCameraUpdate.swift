//
//  CameraUpdate.swift
//  CercaliaSDK
//

import UIKit

/**
 CameraUpdate defines a camera move.
 
 ### Usage example: ###
 
 ````
 // Zoom out on a map:
 let mapController: CMMapController = ...
 _ = mapController.animateCamera(cameraUpdate: CMCameraUpdateFactory.zoomOut())
 
 ````
 */
public class CMCameraUpdate: NSObject {

    internal var position: CMLatLng?
    internal var zoom: Float?
    internal var rotation: Float?
    internal var deltaZoom: Float?
    internal var tilt: Float?
    
    internal var bounds: CMLatLngBounds?;
    internal var paddingPx: Int = 0;

    internal override init() {
    }
    
}
