//
//  SuggestGeocoding.swift
//  CercaliaSDK
//
//  Created by Marc on 6/6/17.
//
//

import UIKit
import Alamofire

/**
 * The CMSuggestGeocoding Delegate.
 */
@objc public protocol CMSuggestGeocodingDelegate: NSObjectProtocol {
    /**
     Suggest geocoding response
     
     - Parameters:
        - result:            the result
        - error:             True if has error
     */
    @objc func suggestGeocodingResponse(result: CMLatLng?, error: Bool);
}

/**
 * <p>The Suggest Geocoding service encapsulates suggestGeocoding queries to cercalia API.
 *
 * The Suggest Geocoder works with an <b>APIKEY</b>. Use the following call to configure it:</p>
 *
 * <pre><code>{CMCercalia.instance.apiKey = API_KEY}</code></pre>
 *
 * <p>Resolution of the queries is done <b>asyncronously</b>, so a delegate must be defined </p>
 * <pre><code>
 * CMSuggestGeocoding.getInstance().geocoding(address, delegate: self);
 * </code></pre>
 *
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 */
public class CMSuggestGeocoding {
    private let log: CMLog = CMLog("CMRemoveObservable");
    
    /// Intance
    static let instance = CMSuggestGeocoding()
    
    /**
     Gets instance.
     
      - Returns: the instance
     */
    public static func getInstance() -> CMSuggestGeocoding {
        return instance;
    }
    
    /**
     Geocoding.
     
     - Parameters:
        - cityCode:    the city code
        - streetCode:  the street code
        - houseNumber: the house number
        - delegate:    the delegate
     */
    public func geocoding(cityCode:String?,
                          streetCode:String?,
                          houseNumber:String?,
                          delegate: CMSuggestGeocodingDelegate){
        
        let parameters: Parameters = [
            "key": CMCercalia.instance.apiKey ?? "",
            "ctc": cityCode ?? "",
            "stc": streetCode ?? "",
            "stnum": houseNumber ?? ""
        ];
        
        
        //Networking in Alamofire is done asynchronously
        Alamofire.request("https://lb.cercalia.com/suggest/SuggestServlet", parameters: parameters).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                let json = response.result.value;
                let coords = self.getLatLngFromResponse(response: json as! NSDictionary);
                delegate.suggestGeocodingResponse(result: coords, error: false);
                break;
            case .failure:
                delegate.suggestGeocodingResponse(result: nil, error: true);
                break;
            }
        }
    }
    
    /**
     Geocoding.
     
     - Parameters:
        - address:  the address
        - delegate: the delegate
     */
    public func geocoding(address: CMAddress, delegate: CMSuggestGeocodingDelegate) {
        let cityCode = address.hasCity() ? address.getCity()?.getCode() : nil;
        let streetCode = address.hasRoad() ? address.getRoad()?.getCode() : nil;
        
        let properties = address.hasRoad() && (address.getRoad()?.hasProperties())! && address.getRoad()?.getProperties() is StreetProperties ? (address.getRoad()?.getProperties() as! StreetProperties) : nil;
        let houseNumber = properties != nil ? (properties!.getHouseNumber())! as String : nil;
        
        self.geocoding(cityCode: cityCode as? String, streetCode: streetCode as? String, houseNumber: houseNumber, delegate: delegate);
    }
    
    private func getLatLngFromResponse(response:NSDictionary) -> CMLatLng? {
        if(response.count > 0){
            do{
                let coords = (response.object(forKey: "response") as! NSDictionary).object(forKey: "coord") as! NSDictionary;
                let x = coords.object(forKey: "x") as! Double;
                let y = coords.object(forKey: "y") as! Double;
                
                return CMLatLng(y,x);
            }
        }
        else{
            self.log.e(tag: "SuggestService", info: "No response")
            return nil;
        }
    }
}
