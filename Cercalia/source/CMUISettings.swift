//
//  CMUiSettings.swift
//  CercaliaSDK
//
//  Created by David Comas on 30/5/17.
//
//

import Foundation
import UIKit

/**
 Map UISettings.
 
 ### Usage example: ###
 
 ````
 // zoom controls enable
 let mapController: CMMapController = ...
 mapController.settings.zoomControls = true
 ````
 */
public class CMUISettings : NSObject {
    
    private static let MARGIN: CGFloat = 16
    private static let MARGIN_ZOOM_COMPONENTS: CGFloat = 5
    private static let BUTTON_SIZE : CGFloat = 48
    
    //Icons
    private let ICON_LOCATION : String = "gps"
    private let ICON_ZOOM_IN : String = "plus"
    private let ICON_ZOOM_OUT : String = "less"
    private let ICON_COMPASS : String = "north"
    
    // private
    private var map_: CMMapController?
    // map controller
    internal var map: CMMapController?
    {
        get
        {
            return map_
        }
        set(value)
        {
            map_ = value
            self.updateUI()
        }
    }
    
    /// MyLocation Button
    private var myLocationUIButton: UIButton?
    
    /// zoomControlZoomIn Button
    private var zoomControlZoomInUIButton: UIButton?
    
    /// zoomControlZoomOut Button
    private var zoomControlZoomOutUIButton: UIButton?
    
    /// Compass Button
    private var compassUIButton: UIButton?
    
    // attr public
    private var compassButton_: Bool = false
    /// Enable compass Button
    public var compassButton: Bool
    {
        get
        {
            return compassButton_
        }
        set(value)
        {
            compassButton_ = value
            self.updateUI()
        }
    }
    
    private var myLocationButton_: Bool = false
    /// Enable MyLocation Button
    public var myLocationButton: Bool
    {
        get
        {
            return myLocationButton_
        }
        set(value)
        {
            myLocationButton_ = value
            self.updateUI()
        }
    }
    
    private var zoomControls_: Bool = false
    /// Enable ZoomControls
    public var zoomControls: Bool
    {
        get
        {
            return zoomControls_
        }
        set(value)
        {
            zoomControls_ = value
            self.updateUI()
        }
    }
    
    internal override init(){
        super.init()
    }
    
    internal init(map: CMMapController, myLocationUIButton: UIButton, zoomControlZoomInUIButton: UIButton, zoomControlZoomOutUIButton: UIButton, compassUIButton: UIButton) {
        
        super.init()
        
        self.map = map
        
        self.myLocationUIButton = myLocationUIButton
        self.zoomControlZoomInUIButton = zoomControlZoomInUIButton
        self.zoomControlZoomOutUIButton = zoomControlZoomOutUIButton
        self.compassUIButton = compassUIButton
        
        self.updateUI()
    }
    
    internal init(map: CMMapController) {
        super.init()
        
        self.map = map
        self.updateUI()
    }
    
    
    //MARK: UI Fires methods
    
    @objc func myLocationUIButtonClick() {
        if let location = self.map?.myLocation {
            _ = self.map?.animateCamera(cameraUpdate: CMCameraUpdateFactory.new(latLng: location))
        }
    }
    
    @objc func zoomControlZoomInUIButtonClick() {
        _ = self.map?.animateCamera(cameraUpdate: CMCameraUpdateFactory.zoomIn())
    }
    
    @objc func zoomControlZoomOutUIButtonClick() {
        _ = self.map?.animateCamera(cameraUpdate: CMCameraUpdateFactory.zoomOut())
    }
    
    @objc func compassUIButtonClick() {
        self.rotate(radians: 0)
        _ = self.map?.animateCamera(cameraUpdate: CMCameraUpdateFactory.rotation(0))
    }
    
    //MARK: private methods
    
    /// Update/Create buttons
    private func updateUI(){
        // Actualitzem els controls del mapa
        
        
        if self.map  != nil && self.map!.mapView.isCreated &&
            self.map?.mapView.map?.view.frame.width != nil {
            
            let originX: CGFloat = self.map!.mapView.map!.view.frame.width - CMUISettings.MARGIN - CMUISettings.BUTTON_SIZE
            var originY = CMUISettings.MARGIN
            
            //Actualitzem el Botó
            self.myLocationUIButton = self.updateUIButton(self.myLocationUIButton,
                                                          image: CMUtils.image(CMMarker.self, resource: ICON_LOCATION)!,
                                                          enable: self.myLocationButton,
                                                          action: #selector(CMUISettings.myLocationUIButtonClick),
                                                          originX: originX,
                                                          originY: originY)
            
            //Incrementem el origenY
            originY += self.myLocationButton && self.myLocationUIButton != nil ? self.myLocationUIButton!.frame.height + CMUISettings.MARGIN : 0
            
            
            //Actualitzem el Botó
            self.zoomControlZoomInUIButton = self.updateUIButton(self.zoomControlZoomInUIButton,
                                                                 image: CMUtils.image(CMMarker.self, resource: ICON_ZOOM_IN)!,
                                                                 enable: self.zoomControls,
                                                                 action: #selector(CMUISettings.zoomControlZoomInUIButtonClick),
                                                                 originX: originX,
                                                                 originY: originY)
            
            //Incrementem el origenY
            originY += self.zoomControls && self.zoomControlZoomInUIButton != nil ? self.zoomControlZoomInUIButton!.frame.height + CMUISettings.MARGIN_ZOOM_COMPONENTS : 0
            
            
            //Actualitzem el Botó
            self.zoomControlZoomOutUIButton = self.updateUIButton(self.zoomControlZoomOutUIButton,
                                                                  image: CMUtils.image(CMMarker.self, resource: ICON_ZOOM_OUT)!,
                                                                  enable: self.zoomControls,
                                                                  action: #selector(CMUISettings.zoomControlZoomOutUIButtonClick),
                                                                  originX: originX,
                                                                  originY: originY)
            
            //Incrementem el origenY
            originY += self.zoomControls && self.zoomControlZoomOutUIButton != nil ? self.zoomControlZoomOutUIButton!.frame.height + CMUISettings.MARGIN : 0
            
            
            //Actualitzem el Botó
            self.compassUIButton = self.updateUIButton(self.compassUIButton,
                                                       image: CMUtils.image(CMMarker.self, resource: ICON_COMPASS)!,
                                                       enable: self.compassButton,
                                                       action: #selector(CMUISettings.compassUIButtonClick),
                                                       originX: originX,
                                                       originY: originY)
            
            if let rounderedButton = self.compassUIButton as? CMUISettingsButton {
                rounderedButton.rounded = true
            }
        }
    }
    
    /// Create/Update Button
    private func updateUIButton(_ button: UIButton?, image: UIImage, enable: Bool, action: Selector, originX: CGFloat, originY: CGFloat ) -> UIButton? {
        var button: UIButton? = button
        
        //Actualitzem l'estat de UIBUtton
        
        if enable && button == nil {
            button = CMUISettingsButton(frame: CGRect(x: originX, y: originY, width: CMUISettings.BUTTON_SIZE, height: CMUISettings.BUTTON_SIZE),
                                        image: image)
            button?.addTarget(self, action: action, for: .touchUpInside)
            
            self.map?.mapView.addSubview(button!)
            
        }else if enable {
            button?.frame = CGRect(x: originX, y: originY, width: CMUISettings.BUTTON_SIZE, height: CMUISettings.BUTTON_SIZE)
            button?.isHidden = false
            
        }else {
            button?.isHidden = true
        }
        
        return button
    }
    
    
    /**
     * called when map rotated.
     */
    internal func onRotated(){
        let radiantsRotationMap = self.map!.getCameraPosition().rotation
        
        animateRotate(radians: CGFloat(radiantsRotationMap));
    }
    
    /**
     * Rotate animated compass-image.
     *
     * @param degrees map rotation in degrees
     */
    private func animateRotate(radians: CGFloat){
        self.compassUIButton?.transform = CGAffineTransform(rotationAngle: radians)
    }
    
    /**
     * Rotate compass-image.
     *
     * @param degrees map rotation in degrees
     */
    private func rotate(radians: CGFloat){
        self.compassUIButton?.transform = CGAffineTransform(rotationAngle: radians)
    }
}
