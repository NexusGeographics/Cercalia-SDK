//
//  CameraUpdateFactory.swift
//  CercaliaSDK
//

import UIKit

/**
 CameraUpdateFactory used to modify map camera.
 */
public class CMCameraUpdateFactory {
    
    /**
     Returns a CameraUpdate that moves the camera to a specified CameraPosition. In effect, this creates a transformation from the CameraPosition object's latitude, longitude, zoom level, bearing and tilt.
     
     ### Usage example: ###
     
     ````
     let mapController: CMMapController = ...
     let cameraPosition: CMCameraPosition = ...
     _ = mapController.animateCamera(cameraPosition: CMCameraUpdateFactory.new(cameraPosition: cameraPosition))
     
     ````
     
     - Parameter cameraPosition: The camera position
     - Returns: The CameraUpdate containing the transformation.
     */
    public static func new(cameraPosition: CMCameraPosition) ->  CMCameraUpdate {
        
        let c = CMCameraUpdate()
        c.position = cameraPosition.position
        c.zoom = cameraPosition.zoom
        c.rotation = cameraPosition.rotation
        return c
    }
    
    /**
     Returns a CameraUpdate that moves the center of the screen to a latitude and longitude specified by a LatLng object. This centers the camera on the LatLng.
     
     ### Usage example: ###
     
     ````
     let mapController: CMMapController = ...
     let latlng: CMLatLng = ...
     _ = mapController.animateCamera(cameraPosition: CMCameraUpdateFactory.new(latLng: latlng))
     
     ````
     
     - Parameter latLng: The coordinate
     - Returns: The CameraUpdate containing the transformation.
     */
    public static func new(latLng: CMLatLng) ->  CMCameraUpdate {
        let c = CMCameraUpdate()
        c.position = latLng
        return c
    }
    
    /**
     Returns a CameraUpdate that moves the camera viewpoint to a particular zoom level.
     
     ### Usage example: ###
     
     ````
     let mapController: CMMapController = ...
     let zoom: Float = 8
     _ = mapController.animateCamera(cameraPosition: CMCameraUpdateFactory.zoomTo(zoom))
     
     ````
     
     - Parameter zoom: The zoom
     - Returns: The CameraUpdate containing the transformation.
     */
    public static func zoomTo(_ zoom: Float) ->  CMCameraUpdate {
        let c = CMCameraUpdate()
        c.zoom = zoom
        return c
    }
    
    /**
     Returns a CameraUpdate that moves the center of the screen to a latitude and longitude specified by a LatLng object, and moves to the given zoom level.
     
     ### Usage example: ###
     
     ````
     let mapController: CMMapController = ...
     let latlng: CMLatLng = ...
     let zoom: Float = 8
     _ = mapController.animateCamera(cameraPosition: CMCameraUpdateFactory.new(latLng: latlng, zoom: zoom))
     
     ````
     
     - Parameter latLng: The coordinate
     - Parameter zoom: The zoom
     - Returns: The CameraUpdate containing the transformation.
     */
    public static func new(latLng: CMLatLng, zoom: Float) ->  CMCameraUpdate {
        let c = CMCameraUpdate()
        c.position = latLng
        c.zoom = zoom
        return c
    }
    
    /**
     Returns a CameraUpdate that moves the center of the screen to a latitude and longitude specified by a LatLng object, and moves to the given zoom level.
     
     ### Usage example: ###
     
     ````
     let mapController: CMMapController = ...
     let latlng: CMLatLng = ...
     let zoom: Float = 8
     _ = mapController.animateCamera(cameraPosition: CMCameraUpdateFactory.new(latLng: latlng, zoom: zoom))
     
     ````
     
     - Parameter latLng: The coordinate
     - Parameter zoom: The zoom
     - Returns: The CameraUpdate containing the transformation.
     */
    public static func new(bounds: CMLatLngBounds, paddingPx: Int) ->  CMCameraUpdate {
        let c = CMCameraUpdate()
        c.bounds = bounds;
        c.paddingPx = paddingPx;
        return c
    }
    
    /**
     Returns a CameraUpdate that rotate map.
     
     ### Usage example: ###
     
     ````
     let mapController: CMMapController = ...
     let rotation: Float = 0.5
     _ = mapController.animateCamera(cameraPosition: CMCameraUpdateFactory.rotation(rotation))
     
     ````
     
     - Parameter rotation: The rotation in radians; 0 corresponds to North pointing up
     - Returns: The CameraUpdate containing the transformation.
     */
    public static func rotation(_ rotation: Float) ->  CMCameraUpdate {
        let c = CMCameraUpdate()
        c.rotation = rotation
        return c
    }
    
    /**
     Returns a CameraUpdate that zoom in on the map increments in 1.0.
     
     ### Usage example: ###
     
     ````
     let mapController: CMMapController = ...
     _ = mapController.animateCamera(cameraPosition: CMCameraUpdateFactory.zoomIn())
     
     ````
     
    - Returns: The CameraUpdate containing the transformation.
     */
    public static func zoomIn() ->  CMCameraUpdate {
        let c = CMCameraUpdate()
        c.deltaZoom = 1
        return c
    }
    
    /**
     Returns a CameraUpdate that zoom in on the map decrement in 1.0.
     
     ### Usage example: ###
     
     ````
     let mapController: CMMapController = ...
     _ = mapController.animateCamera(cameraPosition: CMCameraUpdateFactory.zoomOut())
     
     ````
     
     - Returns: The CameraUpdate containing the transformation.
     */
    public static func zoomOut() ->  CMCameraUpdate {
        let c = CMCameraUpdate()
        c.deltaZoom = -1
        return c
    }
}
