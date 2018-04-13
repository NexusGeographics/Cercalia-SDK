//
//  Geocoder.swift
//  CercaliaSDK
//
//  Created by Marc on 7/6/17.
//
//

import UIKit
import Alamofire

/**
 * The CMSuggestGeocoding Delegate.
 */
public protocol CMReverseGeocodingDelegate: NSObjectProtocol {
    /**
     Suggest geocoding response
     
     - Parameters:
        - result:            the result
        - error:             True if has error
     */
    func suggestResponse(result: Array<CMAddress>?, nativeResponse: String?, error: Bool);
}

/**
 * <p>The Geocoder service encapsulates reverse geocoding queries to cercalia API.
 *
 * The Geocoder works with an <b>APIKEY</b>. Use the following call to configure it:</p>
 *
 * <pre><code> CMCercalia.instance.apiKey = API_KEY</code></pre>
 *
 * <p>Resolution of the queries is done <b>asyncronously</b>, so a delegate must be defined:</p>
 * <pre><code>
 * CMGeocoder.getInstance().reverseGeocoding.getFromLocation(latLng: latLng, delegate: self); 
 * </code></pre>
 *
 * <p>Copyright (c) 2017 Nexusgeographics All rights reserved.</p>
 *
 */
public class CMGeocoder {
    private static let CMD_REVERSEGEOCODING = "reversegeocoding"
    
    /// Intance
    static let instance = CMGeocoder()
    
    /**
      Gets instance.
     
      - returns: the instance
     */
    public static func getInstance() -> CMGeocoder {
        return instance;
    }
    
    /**
     Main method to resolve reverse geocoding with Cercalia.
     
     - Parameters:
        - latLng:   coordinates of the location
        - delegate: the delegate to treat the response
     */
    public func getFromLocation(latLng: CMLatLng, delegate: CMReverseGeocodingDelegate){
        let parameters: Parameters = [
            "key": CMCercalia.instance.apiKey ?? "",
            "cmd": CMGeocoder.CMD_REVERSEGEOCODING,
            "mo": String(latLng.lat) + "," + String(latLng.lng)
        ];
        
        
        //Networking in Alamofire is done asynchronously
        Alamofire.request("https://lb.cercalia.com/api/RequestsAPI", parameters: parameters).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                let json = response.result.value;
                let addreResponse = self.createResponse(response: json as! NSDictionary);
                
                let hasError = (json == nil || ((json as! NSDictionary).object(forKey: "error") != nil && ((json as! NSDictionary).object(forKey: "error") as! NSDictionary).count > 0));
                
                var nativeResponse:String? = nil;
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    nativeResponse = !hasError ? utf8Text : nil;
                }

                delegate.suggestResponse(result: addreResponse, nativeResponse: nativeResponse, error: hasError);
                break;
            case .failure:
                delegate.suggestResponse(result: nil, nativeResponse: nil, error: true);
                break;
            }
        }
    }
    
    private func createResponse(response: NSDictionary) -> Array<CMAddress> {
        var addressList = Array<CMAddress>();
        
        let arrGe = self.getCercaliaGe(jsonElement: response); // Obtenim la llista de GE's
        let type = self.getCercaliaGetType(jsonElement: response); // Obtenim el tipus de GE's que retorna la resposa de Cercalia
        
        for ge in arrGe {
            let address = ge.create(type: type);
            //if(address != nil){
                addressList.append(address);
            //}
        }
        
        return addressList;
    }
    
    private func getCercaliaGetType(jsonElement: NSDictionary) -> String {
        let cercaliaGeList = ((jsonElement.object(forKey: "cercalia") as! NSDictionary).object(forKey: "proximity") as! NSDictionary).object(forKey: "gelist") as! NSDictionary;
        let type = cercaliaGeList.object(forKey: "type");
        return type != nil ? type as! String : "";
    }
    
    private func getCercaliaGe(jsonElement: NSDictionary) -> Array<CMGe> {
        let cercaliaGeList = ((jsonElement.object(forKey: "cercalia") as! NSDictionary).object(forKey: "proximity") as! NSDictionary).object(forKey: "gelist") as! NSDictionary;
        
        let jsonGe = cercaliaGeList.object(forKey: "ge") as AnyObject;
        if (jsonGe is Array<NSDictionary>){
            return self.geArrayFromJsonArray(jsonGe: jsonGe as! Array<NSDictionary>);
        }
        else {
            return self.geArrayFromJsonObject(jsonGe: jsonGe as! NSDictionary);
        }
    }
    
    private func geArrayFromJsonArray(jsonGe: Array<NSDictionary>) -> Array<CMGe>{
        var geArr = Array<CMGe>();
        for dict: NSDictionary? in jsonGe {
            if dict != nil {
                let ge = CMGe(dic: dict!);
                //if(ge != nil){
                    geArr.append(ge);
                //}
            }
        }
        
        return geArr;
    }
    
    private func geArrayFromJsonObject(jsonGe: NSDictionary) -> Array<CMGe> {
        var geArr = Array<CMGe>();
        let ge = CMGe(dic: jsonGe);
        //if(ge != nil) {
            geArr.append(ge);
        //}
        
        return geArr;
    }
}
