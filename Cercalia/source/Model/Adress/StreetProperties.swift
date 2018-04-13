//
//  StreetProperties.swift
//  CercaliaSDK
//
//  Created by Marc on 13/6/17.
//
//

import UIKit

/**
 * Copyright (c) 2017 Nexusgeographics All rights reserved.
 *
 * The Street Properties Class.
 */
public class StreetProperties: Road.Properties {
    private var houseNumber: String?;
    private var houseNumberMin: Int?;
    private var houseNumberMax: Int?;
    
    /**
     * Instantiates a new Street properties.
     *
     * - parameter velocity:   the velocity
     * - parameter houseNumer: the house numer
     */
    init(velocity: String?, houseNumber: String?) {
        self.houseNumber = houseNumber;
        super.init(velocity: velocity);
    }
    
    /**
     * Instantiates a new Street properties.
     *
     * - parameter velocity:      the velocity
     * - parameter houseNumer:    the house numer
     * - parameter houseNumerMin: the house numer min
     * - parameter houseNumerMax: the house numer max
     */
    init(velocity: String?, houseNumber: String?, houseNumberMin: Int?, houseNumberMax: Int?) {
        self.houseNumber = houseNumber;
        self.houseNumberMin = houseNumberMin;
        self.houseNumberMax = houseNumberMax;
        super.init(velocity: velocity);
    }
    
    /**
     * Instantiates a new Street properties.
     *
     * - parameter velocity:      the velocity
     * - parameter houseNumer:    the house numer
     * - parameter houseNumerMin: the house numer min
     * - parameter houseNumerMax: the house numer max
     */
    init(velocity: String?, houseNumber: Int?, houseNumberMin: Int?, houseNumberMax: Int?) {
        self.houseNumber = houseNumber != nil ? String(describing: houseNumber): nil;
        self.houseNumberMin = houseNumberMin;
        self.houseNumberMax = houseNumberMax;
        super.init(velocity: velocity);
    }
    
    /**
     * Has house numer boolean.
     *
     * - returns: the boolean
     */
    public func hasHouseNumber() -> Bool {
        return self.houseNumber != nil;
    }
    
    /**
     * Gets house numer.
     *
     * - returns: the house numer
     */
    public func getHouseNumber() -> String? {
        return self.houseNumber;
    }
    
    /**
     * Sets house numer.
     *
     * - parameter houseNumer: the house numer
     */
    public func setHouseNumber(houseNumber: String?) {
        self.houseNumber = houseNumber;
    }
    
    /**
     * Has house numer min boolean.
     *
     * - returns: the boolean
     */
    public func hasHouseNumberMin() -> Bool {
        return self.houseNumberMin != nil;
    }
    
    /**
     * Gets house numer min.
     *
     * - returns: the house numer min
     */
    public func getHouseNumberMin() -> Int? {
        return self.houseNumberMin;
    }
    
    /**
     * Sets house numer min.
     *
     * - parameter houseNumerMin: the house numer min
     */
    public func setHouseNumberMin(houseNumberMin: Int?) {
        self.houseNumberMin = houseNumberMin;
    }
    
    /**
     * Has house numer max boolean.
     *
     * - returns: the boolean
     */
    public func hasHouseNumberMax() -> Bool {
        return self.houseNumberMax != nil;
    }
    
    /**
     * Gets house numer max.
     *
     * - returns: the house numer max
     */
    public func getHouseNumberMax() -> Int? {
        return self.houseNumberMax;
    }
    
    /**
     * Sets house numer max.
     *
     * - parameter houseNumerMax: the house numer max
     */
    public func setHouseNumberMax(houseNumberMax: Int?) {
        self.houseNumberMax = houseNumberMax;
    }
}
