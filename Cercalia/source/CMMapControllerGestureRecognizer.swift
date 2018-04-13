//
//  CMMaoControllerGesture.swift
//  CercaliaSDK
//
//  Created by David Comas on 29/5/17.
//
//

import UIKit
import TangramMap

/// Extencion to add `TGRecognizerDelegate`
extension CMMapController: TGRecognizerDelegate
{
    
    // MARK: Methods

    /// Add pickers to detect clicks on features.
    private func addPickers(location: CGPoint) {
        
        self.mapView.map?.pickFeature(at: location)
        self.mapView.map?.pickLabel(at: location)
        self.mapView.map?.pickMarker(at: location)
        self.mapView.map?.setPickRadius(5)
    }
    

    // MARK: TGRecognizerDelegate - did Recognize
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, didRecognizeSingleTapGesture location: CGPoint) {
        log.d(tag: "GESTURE", info: " didRecognizeSingleTapGesture")
        
        self.addPickers(location: location)
        self.delegate?.map?(self, onClick: CMLatLng(self, point: location))
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, didRecognizeDoubleTapGesture location: CGPoint) {
        log.d(tag: "GESTURE", info: " didRecognizeDoubleTapGesture")
        
        self.delegate?.map?(self, onDoubleClick: CMLatLng(self, point: location))
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, didRecognizeLongPressGesture location: CGPoint) {
        log.d(tag: "GESTURE", info: " didRecognizeLongPressGesture")
        
        self.delegate?.map?(self, onLongClick: CMLatLng(self, point: location))
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, didRecognizePanGesture displacement: CGPoint) {
        log.d(tag: "GESTURE", info: " didRecognizePanGesture")
        
        self.delegate?.map?(self, onPan: displacement)
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, didRecognizePinchGesture location: CGPoint) {
        log.d(tag: "GESTURE", info: " didRecognizePinchGesture")
        
        self.delegate?.map?(self, onPinch: CMLatLng(self, point: location))
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, didRecognizeRotationGesture location: CGPoint) {
        log.d(tag: "GESTURE", info: " didRecognizeRotationGesture")
        
        self.settings.onRotated()
        let rotation = self.getCameraPosition().rotation
        self.delegate?.map?(self, onRotation: rotation)
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, didRecognizeShoveGesture displacement: CGPoint) {
        log.d(tag: "GESTURE", info: " didRecognizeShoveGesture")
        
        self.delegate?.map?(self, onShove: displacement)
    }
    
    
    // MARK: TGRecognizerDelegate - should Recognize
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, shouldRecognizeSingleTapGesture location: CGPoint) -> Bool {
        return true
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, shouldRecognizeDoubleTapGesture location: CGPoint) -> Bool {
        return true
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, shouldRecognizeLongPressGesture location: CGPoint) -> Bool {
        return true
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, shouldRecognizePanGesture displacement: CGPoint) -> Bool {
        return true
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, shouldRecognizePinchGesture location: CGPoint) -> Bool {
        return true
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, shouldRecognizeRotationGesture location: CGPoint) -> Bool {
        return true
    }
    
    public func mapView(_ view: TGMapViewController, recognizer: UIGestureRecognizer, shouldRecognizeShoveGesture displacement: CGPoint) -> Bool {
        return true
    }
}
