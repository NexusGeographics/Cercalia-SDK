//
//  Road.swift
//  CercaliaSDK
//
//  Created by Marc on 13/6/17.
//
//

import UIKit

/**
 * Copyright (c) 2017 Nexusgeographics All rights reserved.
 *
 * The Road Class.
 * - SeeAlso: CMCodeName
 */
public class Road: CMCodeName {
    private var properties: Properties?
    
    /**
     * Road line string.
     *
     * - returns: the string
     */
    public func roadLine() -> String? {
        let streetProperties: StreetProperties? = (self.hasProperties() && self.getProperties() is StreetProperties) ? (self.getProperties() as! StreetProperties) : nil;
        
        let housenumber: String? = streetProperties != nil && streetProperties?.getHouseNumber() != nil ? streetProperties!.getHouseNumber() : nil;
        
        let roadProperties: RoadProperties? = (self.hasProperties() && self.getProperties() is RoadProperties) ? (self.getProperties() as! RoadProperties) : nil;
        
        let km: String? = roadProperties != nil && roadProperties?.getKm() != nil ? String(describing: roadProperties!.getKm()) : nil;
        
        return self.getName() as! String + (housenumber != nil ? " " + housenumber! : km != nil ? " " + km! : "");
    }
    
    /**
     * Has properties.
     *
     * - returns: true if has properties
     */
    public func hasProperties() -> Bool {
        return self.properties != nil;
    }
    
    /**
     * Gets properties.
     *
     * - returns: the properties
     */
    public func getProperties() -> Properties? {
        return self.properties;
    }
    
    /**
     * Sets properties.
     *
     * - Parameter properties: the properties
     */
    public func setProperties(properties: Properties?){
        self.properties = properties;
    }
    
    /**
     * The type Properties.
     */
    public class Properties {
        private var velocity: String?;
        
        /**
         * Instantiates a new Properties.
         *
         * - Parameter velocity: the velocity
         */
        init(velocity: String?) {
            self.velocity = velocity;
        }
        
        /**
         * Has velocity.
         *
         * - returns: true if has velocity
         */
        public func hasVelocity() -> Bool {
            return self.velocity != "";
        }
        
        /**
         * Gets velocity.
         *
         * - returns: the velocity
         */
        public func getVelocity() -> String? {
            return self.velocity;
        }
        
        /**
         * Sets velocity.
         *
         * - Parameter velocity: the velocity
         */
        public func setVelocity(velocity: String){
            self.velocity = velocity;
        }
    }
}
