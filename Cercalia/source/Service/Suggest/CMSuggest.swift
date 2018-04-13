//
//  CMSuggest.swift
//  CercaliaSDK
//
//  Created by Marc on 7/6/17.
//
//

import UIKit
import Alamofire

/**
 * The CMSuggest Delegate.
 */
public protocol CMSuggestDelegate: NSObjectProtocol {
    /**
      Suggest suggest response
    
     - Parameters:
        - result:            list of address
        - nativeresponse:    the native suggestresponse
        - error:             True if has error
    */
    func response(result: Array<CMAddress>, nativeResponse: String?, error: Bool);
}

/**
 *
 * <p>The Suggest service encapsulates suggest queries to cercalia API.
 *
 * The Suggest works with an APIKEY. Use the following call to configure it:</p>
 *
 * <pre><code> CMCercalia.instance.apiKey = API_KEY</code></pre>
 *
 * Resolution of the queries is done <b>asyncronously</b>, so a delegate must be defined
 *
 * <pre><code> CMSuggest.getInstance().suggest(text, delegate);</code></pre>
 *
 *
 * <p> Copyright (c) 2017 Nexusgeographics All rights reserved. </p>
 *
 */
public class CMSuggest {
    private let log: CMLog = CMLog("CMRemoveObservable");
    
    /// Intance
    static let instance = CMSuggest()
    
    public static func getInstance() -> CMSuggest {
        return instance;
    }
    
    /**
     The enum Type Address
    */
    public enum Types {
        case STREET
        case CITY
        case POIS
        
        public func toString() -> String {
            switch self {
                case .POIS:
                    return "p";
                case .STREET:
                    return "st";
                case .CITY:
                    return "ct";
            }
        }
    }
    
    private var types = [Types.STREET, Types.CITY];
    
    /**
     Sets types
     
     - Parameter types: the types
    */
    public func setTypes(types: Array<Types>){
        self.types = types;
    }
    
    /**
     Gets types
     
     - returns: the types
     */
    public func getTypes() -> Array<Types> {
        return self.types;
    }
    
    /**
     Suggest.
     
     - Parameters:
        - t:        the query
        - delegate: the delegate
     */
    public func suggest(t:String, delegate:CMSuggestDelegate) {
        let parameters: Parameters = [
            "key": CMCercalia.instance.apiKey ?? "",
            "gettype": self.getTypeParam(),
            "t": t
        ];
        
        
        //Networking in Alamofire is done asynchronously
        Alamofire.request("https://lb.cercalia.com/suggest/SuggestServlet", parameters: parameters).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                let json = response.result.value;
                let hasError = (json == nil || ((json as! NSDictionary).object(forKey: "error") != nil && ((json as! NSDictionary).object(forKey: "error") as! NSDictionary).count > 0));
                let suggestionList = self.createResponse(response: json as! NSDictionary);
                
                var nativeResponse:String? = nil;
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    nativeResponse = !hasError ? utf8Text : nil;
                }
                delegate.response(result: suggestionList, nativeResponse: nativeResponse, error: hasError);
                break;
            case .failure:
                break;
            }
        }
    }
    
    public func createResponse(response: NSDictionary) -> Array<CMAddress> {
        var addressList = Array<CMAddress>();
        
        if(response.count > 0){
            let docs = (response.object(forKey: "response") as! NSDictionary).object(forKey: "docs") as! NSArray;
                
            for addr in docs {
                let suggestion = CMSuggestion(dic: addr as! NSDictionary);
                addressList.append(suggestion.create());
            }
        }
        
        return addressList;
    }
    
    /**
      Cancel the current query
     */
    public func cancel() {
        Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
            tasks.forEach({task in
                if task.currentRequest?.url?.lastPathComponent == "SuggestServlet"
                {
                    task.cancel()
                }
            })
        }
    }
    
    /**
      Cancel the current query
     */
    private func getTypeParam() -> String {
        var typesArray = Array<String>();
        
        for type:Types in self.types {
            typesArray.append(type.toString());
        }
        
        return CMUtils.arrayToStringSeparated(array: typesArray, separatedBy: ",");
    }
}
