//
//  CMMapView.swift
//  CercaliaSDK
//

import UIKit
import TangramMap

open class CMMapView: UIView {
    
    //Log
    let log: CMLog = CMLog("CMMapViewController");
    
    //Map
    internal weak var map: TGMapViewController?
    
    public var isCreated: Bool = false
    
    // Create map view programally
    internal func create(){
        self.createTangramMap()
        self.isCreated = true
    }
    // Create TGMapViewController inside UIView.
    private func createTangramMap(){
        // Creem el Tangram Map VC amb la vista GLKView (necessari)
        
        self.map = TGMapViewController();
        self.map?.view.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        let glkView: GLKView = GLKView()
        self.map?.view.addSubview(glkView)
        if self.map != nil {
            self.addSubview(self.map!.view)
        }else{
            log.e(tag: "CreateMap", info: "Error on create map")
        }
    }
    
    /**
     Load scene file
 
     - Parameter scene: the scene path URL
     */
    public func loadSceneFileAsync(scene : String){
        //self.map?.loadSceneAsync(from: URL(fileURLWithPath: scene))
        self.map?.loadSceneFileAsync(scene)
    }
    
    /**
     Loads a scene asynchronously, with a list of updates to be applied to the scene.
     If a scene update error happens, scene updates won't be applied.
     
     - Parameter scene: the scene path URL
     - Parameter keyPath: the key path
     - Parameter newValue: new value
     */
    public func loadSceneFileAsync(scene : String, keyPath: String, newValue: String){
        //self.map?.loadSceneAsync(from: URL(fileURLWithPath: scene), with: [TGSceneUpdate(path: keyPath, value: newValue)])
        self.map?.loadSceneFileAsync(scene, sceneUpdates: [TGSceneUpdate(path: keyPath, value: newValue)])
    }

}
