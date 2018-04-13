//
//  Address.swift
//  CercaliaSDK
//
//  Created by Marc on 13/6/17.
//
//

import UIKit

public protocol CoordinateAddressDelegate: NSObjectProtocol {
    func coordinate(coordinate: CMLatLng?, address: CMAddress);
}

public class CMAddress {
    /**
     * The enum Type Address.
     */
    public enum CMType {
        /**
         * Address type.
         */
        case ADDRESS
        /**
         * Road/Street type.
         */
        case STREET
        /**
         * City type.
         */
        case CITY
        /**
         * Postalcode type.
         */
        case POSTAL_CODE
        /**
         * Municipality type.
         */
        case MUNICIPALITY
        /**
         * Subregion type.
         */
        case SUBREGION
        /**
         * Region type.
         */
        case REGION
        /**
         * Country type.
         */
        case COUNTRY
        
        public func toString() -> String {
            switch self {
                case .ADDRESS:
                    return String(describing: AddressType.adr);
                case .STREET:
                    return String(describing: AddressType.st);
                case .CITY:
                    return String(describing: AddressType.ct);
                case .POSTAL_CODE:
                    return String(describing: AddressType.pcode);
                case .MUNICIPALITY:
                    return String(describing: AddressType.mun);
                case .SUBREGION:
                    return String(describing: AddressType.subreg);
                case .REGION:
                    return String(describing: AddressType.reg);
                case .COUNTRY:
                    return String(describing: AddressType.ctry);
            }
        }
    }
    
    /**
     * The enum Type Cercalia Address.
     */
    private enum AddressType {
        /**
         * Adr address type.
         */
        case adr
        /**
         * St address type.
         */
        case st
        /**
         * Ct address type.
         */
        case ct
        /**
         * Pcode address type.
         */
        case pcode
        /**
         * Mun address type.
         */
        case mun
        /**
         * Subreg address type.
         */
        case subreg
        /**
         * Reg address type.
         */
        case reg
        /**
         * Ctry address type.
         */
        case ctry
    }

    private var road: Road?;
    private var coordinate: CMLatLng?;
    private var postalCode: String?;
    private var city: City?;
    private var municipality: Municipality?;
    private var subregion: SubRegion?;
    private var region: Region?;
    private var country: Country?;
    
    /**
     Address line string.
    
     - Returns: address information line string
     */
    public func addressLine() -> String {
        return CMUtils.arrayToStringSeparated(array: self.addressArray(), separatedBy: ", ")
    }
    
    /**
      Address array list.
     
      - Returns: address information array list
     */
    public func addressArray() -> Array<String> {
        var addressNames = Array<String>();
    
        if(self.hasRoad()){
            let roadLine = self.road!.roadLine();
            if(roadLine != nil){
                addressNames.append(roadLine!);
            }
        }
        
        if(self.hasCity() && self.city!.getName() != nil && !addressNames.contains(self.city!.getName() as! String)){
            var cityName = self.city!.getName() as! String;
            if(self.hasPostalCode()){
                cityName = self.getPostalCode()! + " " + cityName;
            }
            addressNames.append(cityName);
        }
        
        if(self.hasMunicipality() && self.municipality?.getName() != nil && !addressNames.contains(self.municipality!.getName() as! String)){
            addressNames.append(self.municipality!.getName() as! String);
        }
        
        if(self.hasSubregion() && self.subregion?.getName() != nil && !addressNames.contains(self.subregion!.getName() as! String)){
            addressNames.append(self.subregion!.getName() as! String);
        }
        
        if(self.hasRegion() && self.region?.getName() != nil && !addressNames.contains(self.region!.getName() as! String)){
            addressNames.append(self.region!.getName() as! String);
        }
        
        if(self.hasCountry() && self.country?.getName() != nil && !addressNames.contains(self.country!.getName() as! String)){
            addressNames.append(self.country!.getName() as! String);
        }
        
        return addressNames;
    }
    
    /**
      Has road.
     
      - Returns: true if has road
     */
    public func hasRoad() -> Bool {
        return road != nil;
    }
    
    /**
      Has coordinateSuggest.
     
      - Returns: true if has coordinateSuggest
     */
    public func hasCoordinate() -> Bool {
        return coordinate != nil;
    }
    
    /**
     * Has postal code.
     *
     * - Returns: true if has postal code
     */
    public func hasPostalCode() -> Bool {
        return postalCode != nil && !(postalCode?.isEmpty)!;
    }
    
    /**
     * Has city.
     *
     * - Returns: true if has city
     */
    public func hasCity() -> Bool {
        return city != nil;
    }
    
    /**
     * Has municipality.
     *
     * - Returns: true if has municipality
     */
    public func hasMunicipality() -> Bool {
        return municipality != nil;
    }
    
    /**
     * Has subregion.
     *
     * - Returns: true if has subregion
     */
    public func hasSubregion() -> Bool {
        return subregion != nil;
    }
    
    /**
     * Has region.
     *
     * - Returns: true if has region
     */
    public func hasRegion() -> Bool {
        return region != nil;
    }
    
    /**
     * Has country.
     *
     * - Returns: true if has country
     */
    public func hasCountry() -> Bool {
        return country != nil;
    }
    
    // [[ GETTERS AND SETTERS ]]
    
    /**
     * Gets road.
     *
     * - Returns: the road
     */
    public func getRoad() -> Road? {
        return self.road;
    }
    
    /**
     * Sets road.
     *
     * - Parameter road: the road
     */
    public func setRoad(road: Road?) {
        self.road = road;
    }
    
    /**
     * Gets postal code.
     *
     * - Returns: the postal code
     */
    public func getPostalCode() -> String? {
        return self.postalCode;
    }
    
    /**
     * Sets postal code.
     *
     * - Parameter postalCode: the postal code
     */
    public func setPostalCode(postalCode: String?) {
        self.postalCode = postalCode;
    }
    
    /**
     * Gets city.
     *
     * - Returns: the city
     */
    public func getCity() -> City? {
        return self.city;
    }
    
    /**
     * Sets city.
     *
     * - Parameter city: the city
     */
    public func setCity(city: City?) {
        self.city = city;
    }
    
    /**
     * Gets municipality.
     *
     * - Returns: the municipality
     */
    public func getMunicipality() -> Municipality? {
        return self.municipality;
    }
    
    /**
     * Sets municipality.
     *
     * - Parameter municipality: the municipality
     */
    public func setMunicipality(municipality: Municipality?) {
        self.municipality = municipality;
    }
    
    /**
     * Gets coordinate. Use Address.getCoordinateFromGeocoder(callback) when coordinates is null or Address.hasCoordinate() is false.
     *
     * - Returns: the coordinate
     */
    public func getCoordinate() -> CMLatLng? {
        return self.coordinate;
    }
    
    /**
     * Obtain coordinates async from SuggestGeocoding.
     * Used for obtain real coordinates when address has houseNumber or Address.hasCoordinate() is false.
     * - Parameter delegate: delegate function
     */
    public func getCoordinateFromGeocoder(delegate: CoordinateAddressDelegate) {
        let interDelegate = AddressSuggestGeocodingDelegate(finalDelegate: delegate, address: self);
        CMSuggestGeocoding.getInstance().geocoding(address: self, delegate: interDelegate);
    }
    
    /**
     * Sets coordinate.
     *
     * - Parameter coordinate: the coordinate
     */
    public func setCoordinate(coordinate: CMLatLng?) {
        self.coordinate = coordinate;
    }
    
    /**
     * Gets subregion.
     *
     * - Returns: the subregion
     */
    public func getSubregion() -> SubRegion? {
        return self.subregion;
    }
    
    /**
     * Sets subregion.
     *
     * - Parameter subregion: the subregion
     */
    public func setSubregion(subregion: SubRegion?) {
        self.subregion = subregion;
    }
    
    /**
     * Gets region.
     *
     * - Returns: the region
     */
    public func getRegion() -> Region? {
        return self.region;
    }
    
    /**
     * Sets region.
     *
     * - Parameter region: the region
     */
    public func setRegion(region:Region?) {
        self.region = region;
    }
    
    /**
      Gets country.
     
      - returns: the country
     */
    public func getCountry() -> Country? {
        return self.country;
    }
    
    /**
     * Sets country.
     *
     * - Parameter country: the country
     */
    public func setCountry(country:Country?) {
        self.country = country;
    }
    
    public func toString() -> String {
        return self.addressLine();
    }
    
    private class AddressSuggestGeocodingDelegate : NSObject, CMSuggestGeocodingDelegate{
        private var finalDelegate : CoordinateAddressDelegate;
        private var address: CMAddress;
        
        init(finalDelegate: CoordinateAddressDelegate, address: CMAddress) {
            self.finalDelegate = finalDelegate;
            self.address = address;
        }
        
        func suggestGeocodingResponse(result: CMLatLng?, error: Bool) {
            self.address.coordinate = result;
            if(!error){
                self.finalDelegate.coordinate(coordinate: result, address: self.address);
            }
            else{
                self.finalDelegate.coordinate(coordinate: nil, address: self.address);
            }
        }
    }
}
