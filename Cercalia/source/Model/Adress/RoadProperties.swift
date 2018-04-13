//
//  RoadProperties.swift
//  CercaliaSDK
//
//  Created by Marc on 13/6/17.
//
//

import UIKit

/**
 * Copyright (c) 2017 Nexusgeographics All rights reserved.
 *
 * The Road Properties Class.
 */
public class RoadProperties: Road.Properties {
    private var km: Int?;
    
    /**
     * Instantiates a new Road properties.
     *
     * - parameter velocity: the velocity
     * - parameter km:       the km
     */
    init(velocity: String, km: Int?) {
        self.km = km;
        super.init(velocity: velocity);
    }
    
    /**
     * Has km.
     *
     * - returns: true if has km
     */
    public func hasKm() -> Bool {
        return self.km != nil;
    }
    
    /**
     * Gets km.
     *
     * - returns: the km
     */
    public func getKm() -> Int? {
        return self.km;
    }
    
    /**
     * Sets km.
     *
     * - parameter km: the km
     */
    public func setKm(km: Int?) {
        self.km = km;
    }
}
