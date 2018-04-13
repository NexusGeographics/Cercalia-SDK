//
//  CMUISettingsButton.swift
//  CercaliaSDK
//
//  Created by David Comas on 30/5/17.
//
//

import Foundation
import UIKit

public class CMUISettingsButton : UIButton {

    private let CORNER_RADIUS: CGFloat = 6
    
    private var rounded_: Bool  = false
    
    /// Makes rounded button
    public var rounded: Bool {
        get
        {
            return rounded_
        }
        set (value)
        {
            rounded_ = value
            if rounded_ {
                self.layer.cornerRadius = self.frame.width / 2
            }else{
                self.layer.cornerRadius = CORNER_RADIUS
            }
        }
    }
    
    
    public init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        self.setImage(image, for: .normal)
        self.style()
    }
    
    public init(frame: CGRect, text: String) {
        super.init(frame: frame)
        self.setTitle(text, for: .normal)
        self.style()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.style()
    }
    
    
    private func style(){
    
        //Style
        self.backgroundColor = UIColor(rgb: 0xFFFFFF)
        self.layer.cornerRadius = CORNER_RADIUS
        self.layer.borderColor = UIColor(rgb: 0x000000).withAlphaComponent(CGFloat(0x33) / 255.0).cgColor
        self.layer.borderWidth = 1
        
        self.setTitleColor(UIColor(rgb: 0x000000).withAlphaComponent(CGFloat(0x33) / 255.0), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        self.clipsToBounds = true
    }
}
