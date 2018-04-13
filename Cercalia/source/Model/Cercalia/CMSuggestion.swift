//
//  CMSuggestion.swift
//  CercaliaSDK
//
//  Created by Marc on 7/6/17.
//
//

import UIKit

/**
 * Copyright (c) 2017 Nexusgeographics All rights reserved.
 *
 * Cercalia native json class
 */
public class CMSuggestion:CMObject {
    /**
     * The Id.
     */
    var id: String?;
    /**
     * The Calle id.
     */
    var calle_id: String?;
    /**
     * The Calle descripcion.
     */
    var calle_descripcion: String?;
    /**
     * The Calle nombre.
     */
    var calle_nombre: String?;
    /**
     * The Calle tipo.
     */
    var calle_tipo: String?;
    /**
     * The Calle articulo.
     */
    var calle_articulo: String?;
    /**
     * The Localidad id.
     */
    var localidad_id: String?;
    /**
     * The Localidad nombre.
     */
    var localidad_nombre: String?;
    /**
     * The Municipio id.
     */
    var municipio_id: String?;
    /**
     * The Municipio nombre.
     */
    var municipio_nombre: String?;
    /**
     * The Provincia id.
     */
    var provincia_id: String?;
    /**
     * The Provincia nombre.
     */
    var provincia_nombre: String?;
    /**
     * The Comunidad id.
     */
    var comunidad_id: String?;
    /**
     * The Comunidad nombre.
     */
    var comunidad_nombre: String?;
    /**
     * The Pais id.
     */
    var pais_id: String?;
    /**
     * The Pais nombre.
     */
    var pais_nombre: String?;
    /**
     * The Oficial.
     */
    var oficial: String?;
    /**
     * The Portal min.
     */
    var portal_min: Int? = nil;
    /**
     * The Portal max.
     */
    var portal_max: Int? = nil;
    /**
     * The Portal.
     */
    var portal: Int? = nil;
    /**
     * The Coord.
     */
    var coord: String?;
    /**
     * The Kmh.
     */
    var kmh: String?;
    /**
     * The Codigo postal.
     */
    var codigo_postal: String?;
    
    public func CMSuggestion(){}
    
    /**
     * Create address.
     *
     * - returns: the address
     */
    public func create() -> CMAddress {
        let address: CMAddress = CMAddress();
        
        if (self.calle_id != nil && self.calle_descripcion != nil){
            let road = Road(code: self.calle_id, name: self.calle_descripcion);
            let properties = StreetProperties(velocity: self.kmh, houseNumber: self.portal, houseNumberMin: self.portal_min, houseNumberMax: self.portal_max);
            road.setProperties(properties: properties);
            address.setRoad(road: road);
        }
        
        if (self.codigo_postal != nil){
            address.setPostalCode(postalCode: self.codigo_postal);
        }
        
        if (self.localidad_id != nil && self.localidad_nombre != nil) {
            address.setCity(city: City(code: self.localidad_id, name: self.localidad_nombre));
        }
        
        if (self.municipio_id != nil && self.municipio_nombre != nil) {
            address.setMunicipality(municipality: Municipality(code: municipio_id, name: self.municipio_nombre));
        }
        
        if (self.provincia_id != nil && self.provincia_nombre != nil) {
            address.setSubregion(subregion: SubRegion(code: self.provincia_id, name: self.provincia_nombre));
        }
        
        if (self.comunidad_id != nil && self.comunidad_nombre != nil) {
            address.setRegion(region: Region(code: self.comunidad_id, name: self.comunidad_nombre));
        }
        
        if (self.pais_id != nil && self.pais_nombre != nil) {
            address.setCountry(country: Country(code: self.pais_id, name: self.pais_nombre));
        }
        
        // si tenim número de portal no posem la coordenada ja que la coordenada exacte s'obté mitjançant el SuggestGeocoder
        if (self.coord != nil && self.portal != nil){
            var coords: Array<String>? = (self.coord?.components(separatedBy: ","))!;
            if(coords != nil && (coords?.count)! > 1){
                let coordX = Double(coords?[0] ?? "0");
                let coordY = Double(coords?[1] ?? "0");
                
                address.setCoordinate(coordinate: CMLatLng(coordX!, coordY!));
            }
        }
        
        return address;
    }

    /**
     * Gets id.
     *
     * - returns: the id
     */
    public func getId() -> String? {
        return self.id;
    }
    
    /**
     * Gets calle id.
     *
     * - returns: the calle id
     */
    public func getCalleId() -> String? {
        return self.calle_id;
    }
    
    /**
     * Gets calle descripcion.
     *
     * - returns: the calle descripcion
     */
    public func getCalleDescripcion() -> String? {
        return self.calle_descripcion;
    }
    
    /**
     * Gets calle nombre.
     *
     * - returns: the calle nombre
     */
    public func getCalleNombre() -> String? {
        return self.calle_nombre;
    }
    
    /**
     * Gets calle tipo.
     *
     * - returns: the calle tipo
     */
    public func getCalleTipo() -> String? {
        return self.calle_tipo;
    }
    
    /**
     * Gets calle articulo.
     *
     * - returns: the calle articulo
     */
    public func getCalleArticulo() -> String? {
        return self.calle_articulo;
    }
    
    /**
     * Gets localidad id.
     *
     * - returns: the localidad id
     */
    public func getLocalidadId() -> String? {
        return self.localidad_id;
    }
    
    /**
     * Gets localidad nombre.
     *
     * - returns: the localidad nombre
     */
    public func getLocalidadNombre() -> String? {
        return self.localidad_nombre;
    }
    
    /**
     * Gets municipio id.
     *
     * - returns: the municipio id
     */
    public func getMunicipiId() -> String? {
        return self.municipio_id;
    }
    
    /**
     * Gets municipio nombre.
     *
     * - returns: the municipio nombre
     */
    public func getMunicipioNombre() -> String? {
        return self.municipio_nombre;
    }
    
    /**
     * Gets provincia id.
     *
     * - returns: the provincia id
     */
    public func getProvinciaId() -> String? {
        return self.provincia_id;
    }
    
    /**
     * Gets provincia nombre.
     *
     * - returns: the provincia nombre
     */
    public func getProvinciaNombre() -> String? {
        return self.provincia_nombre;
    }
    
    /**
     * Gets comunidad id.
     *
     * - returns: the comunidad id
     */
    public func getComunidadId() -> String? {
        return self.comunidad_id;
    }
    
    /**
     * Gets comunidad nombre.
     *
     * - returns: the comunidad nombre
     */
    public func getComunidadNombre() -> String? {
        return self.comunidad_nombre;
    }
    
    /**
     * Gets pais id.
     *
     * - returns: the pais id
     */
    public func getPaisId() -> String? {
        return self.pais_id;
    }
    
    /**
     * Gets pais nombre.
     *
     * - returns: the pais nombre
     */
    public func getPaisNombre() -> String? {
        return self.pais_nombre;
    }
    
    /**
     * Gets oficial.
     *
     * - returns: the oficial
     */
    public func getOficial() -> String? {
        return self.oficial;
    }
    
    /**
     * Gets portal min.
     *
     * - returns: the portal min
     */
    public func getPortalMin() -> Int? {
        return self.portal_min;
    }
    
    /**
     * Gets portal max.
     *
     * - returns: the portal max
     */
    public func getPortalMax() -> Int? {
        return self.portal_max;
    }
    
    /**
     * Gets portal.
     *
     * - returns: the portal
     */
    public func getPortal() -> Int? {
        return self.portal;
    }
    
    /**
     * Gets coord.
     *
     * - returns: the coord
     */
    public func getCoord() -> String? {
        return self.coord;
    }
    
    /**
     * Gets kmh.
     *
     * - returns: the kmh
     */
    public func getKmh() -> String? {
        return self.kmh;
    }
    
    /**
     * Gets código postal.
     *
     * - returns: the código postal.
     */
    public func getCodigoPostal() -> String? {
        return self.codigo_postal;
    }
}
