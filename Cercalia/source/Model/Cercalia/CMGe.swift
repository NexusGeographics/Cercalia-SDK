//
//  CMGe.swift
//  CercaliaSDK
//
//  Created by Marc on 14/6/17.
//
//

import UIKit

/**
 * Copyright (c) 2017 Nexusgeographics All rights reserved.
 *
 * Cercalia native json class
 */
public class CMGe:CMObject {
    var article: String?;
    var dist: String?;
    var frc: String?;
    var id: String?;
    var kmh: String?;
    var name: String?;
    var pos: String?;
    var prefix: String?;
    var sname: String?;
    var zonename: String?;
    var zonetype: String?;
    var postalcode: PostalCode?;
    var coord: Coords?;
    var km: CMValue?;
    var housenumber: CMValue?;
    
    var intersection: CMGe?;
    
    // Location
    var city: CMKeyValue?;
    var municipality: CMKeyValue?;
    var subregion: CMKeyValue?;
    var region: CMKeyValue?;
    var country: CMKeyValue?;
    
    /**
     * Create address by ge.
     *
     * - Parameter type: the type
     * - returns: the address
     */
    public func create(type: String) -> CMAddress {
        let address: CMAddress = CMAddress();
        
        if (CMAddress.CMType.ADDRESS.toString() == type){
            let road: Road = Road(code: self.id, name: self.name);
            var properties: Road.Properties? = nil;
            
            if (self.km != nil && ((self.km?.getValue()) != nil)) {
                var km: Int? = nil;
                km = Int((self.km?.getValue() as! String))
                properties = RoadProperties(velocity: self.kmh!, km: km);
            }
            else if (self.housenumber != nil && self.housenumber?.getValue() != nil){
                properties = StreetProperties(velocity: self.kmh!, houseNumber: self.housenumber?.getValue() as? String);
            }
            
            road.setProperties(properties: properties);
            address.setRoad(road: road);
        }
        
        if (self.coord != nil && self.coord?.getX() != nil && self.coord?.getY() != nil){
            address.setCoordinate(coordinate: CMLatLng(Double((self.coord?.getY())!)!, Double((self.coord?.getX())!)!));
        }
        
        if (self.postalcode != nil){
            address.setPostalCode(postalCode: self.postalcode?.getId());
        }
        else if (CMAddress.CMType.POSTAL_CODE.toString() == type) {
            address.setPostalCode(postalCode: name);
        }
        
        if (self.city != nil) {
            address.setCity(city: City(code: self.city?.getId() as! String, name: self.city?.getValue() as! String));
        }
        else if (CMAddress.CMType.CITY.toString() == type) {
            address.setCity(city: City(code: self.id!, name: self.name!));
        }
        
        
        if (self.municipality != nil) {
            address.setMunicipality(municipality: Municipality(code: self.municipality?.getId() as! String, name: self.municipality?.getValue() as! String));
        }
        else if (CMAddress.CMType.MUNICIPALITY.toString() == type) {
            address.setMunicipality(municipality: Municipality(code: self.id!, name: self.name!));
        }
        
        
        if (self.subregion != nil) {
            address.setSubregion(subregion: SubRegion(code: self.subregion?.getId() as! String, name: self.subregion?.getValue() as! String));
        }
        else if (CMAddress.CMType.SUBREGION.toString() == type) {
            address.setSubregion(subregion: SubRegion(code: self.id!, name: self.name!));
        }
        
        
        if (self.region != nil) {
            let region = self.region;
            address.setRegion(region: Region(code: region?.getId() as! String, name: region?.getValue() as! String));
        }
        else if (CMAddress.CMType.REGION.toString() == type) {
            address.setRegion(region: Region(code: self.id!, name: self.name!));
        }
        
        
        if (self.country != nil) {
            address.setCountry(country: Country(code: self.country?.getId() as! String, name: self.country?.getValue() as! String));
        }
        else if (CMAddress.CMType.COUNTRY.toString() == type) {
            address.setCountry(country: Country(code: self.id!, name: self.name!));
        }
        
        return address;
    }
    
    /**
     * The type Postal code.
     */
    public class PostalCode:CMObject {
        var country_id: String?;
        var id: String?;
        
        /**
         * Gets country id.
         *
         * - returns: the country id
         */
        public func getCountry_id() -> String? {
            return self.country_id;
        }
        
        /**
         * Gets id.
         *
         * - returns: the id
         */
        public func getId() -> String? {
            return self.id;
        }
    }
    
    /**
     * The type Coords.
     */
    public class Coords:CMObject {
        var x: String?;
        var y: String?;
        
        /**
         * Gets x.
         *
         * - returns: the x
         */
        public func getX() -> String? {
            return self.x;
        }
        
        /**
         * Gets y.
         *
         * - returns: the y
         */
        public func getY() -> String? {
            return self.y;
        }
    }
    
    /**
     * Gets article.
     *
     * - returns: the article
     */
    public func getArticle() -> String? {
        return article;
    }
    
    /**
     * Gets dist.
     *
     * - returns: the dist
     */
    public func getDist() -> String? {
        return dist;
    }
    
    /**
     * Gets frc.
     *
     * - returns: the frc
     */
    public func getFrc() -> String? {
        return frc;
    }
    
    /**
     * Gets id.
     *
     * - returns: the id
     */
    public func getId() -> String? {
        return id;
    }
    
    /**
     * Gets kmh.
     *
     * - returns: the kmh
     */
    public func getKmh() -> String? {
        return kmh;
    }
    
    /**
     * Gets name.
     *
     * - returns: the name
     */
    public func getName() -> String? {
        return name;
    }
    
    /**
     * Gets pos.
     *
     * - returns: the pos
     */
    public func getPos() -> String? {
        return pos;
    }
    
    /**
     * Gets prefix.
     *
     * - returns: the prefix
     */
    public func getPrefix() -> String? {
        return prefix;
    }
    
    /**
     * Gets sname.
     *
     * - returns: the sname
     */
    public func getSname() -> String? {
        return sname;
    }
    
    /**
     * Gets zonename.
     *
     * - returns: the zonename
     */
    public func getZonename() -> String? {
        return zonename;
    }
    
    /**
     * Gets zonetype.
     *
     * - returns: the zonetype
     */
    public func getZonetype() -> String? {
        return zonetype;
    }
    
    /**
     * Gets postalcode.
     *
     * - returns: the postalcode
     */
    public func getPostalcode() -> PostalCode? {
        return postalcode;
    }
    
    /**
     * Gets coord.
     *
     * - returns: the coord
     */
    public func getCoord() -> Coords? {
        return coord;
    }
    
    /**
     * Gets km.
     *
     * - returns: the km
     */
    public func getKm() -> CMValue? {
        return km;
    }
    
    /**
     * Gets intersection.
     *
     * - returns: the intersection
     */
    public func getIntersection() -> CMGe? {
        return intersection;
    }
    
    /**
     * Gets city.
     *
     * - returns: the city
     */
    public func getCity() -> CMKeyValue? {
        return city;
    }
    
    /**
     * Gets municipality.
     *
     * - returns: the municipality
     */
    public func getMunicipality() -> CMKeyValue? {
        return municipality;
    }
    
    /**
     * Gets subregion.
     *
     * - returns: the subregion
     */
    public func getSubregion() -> CMKeyValue? {
        return subregion;
    }
    
    /**
     * Gets region.
     *
     * - returns: the region
     */
    public func getRegion() -> CMKeyValue? {
        return region;
    }
    
    /**
     * Gets country.
     *
     * - returns: the country
     */
    public func getCountry() -> CMKeyValue? {
        return country;
    }
}
