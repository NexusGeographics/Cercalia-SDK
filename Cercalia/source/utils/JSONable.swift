//
//  JSONable.swift
//  CercaliaSDK
//
//  Created by David Comas on 26/5/17.
//
//

import UIKit

public class JSONable : NSObject {

    /// The dictionary where is stored the json values.
    internal var dictionary : Dictionary<String, Any> = Dictionary<String, Any>();
    
    /// The parent of JSONAble.
    internal var parent: JSONable?
    
    /// The key-parent for `this` JSONable .
    internal var key: String?
    
    public override init() {
        super.init()
    }
    
    public init(dictionary : Dictionary<String, Any>) {
        self.dictionary = dictionary
        super.init()
    }
    
    public init(jsonsable: JSONable? ) {
        self.dictionary = jsonsable != nil ? jsonsable!.dictionary : Dictionary<String, Any>()
        super.init()
    }

    /**
        Make style in json.
     
        - Returns: The Style in Json.
     */
    public func toJson() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let s = String.init(data: jsonData, encoding: .utf8)
            return s != nil ? s! : ""
        }catch{}
        return ""
    }
    
    /**
        Update parent information, update should colled after update **JSONable**.
     */
    internal func update(){
        if parent != nil && self.key != nil {
            parent!.set(key: self.key!, value: self)
        }
    }
    
    /**
        Gets dictionary value for key.
     
        - Parameter key: key of value
        - Parameter value: default value of key
        - Returns: The Feature Style.
     */
    internal func get(key: String, defaultStyle value: CMFeatureStyle.Style) -> CMFeatureStyle.Style {
        if ((dictionary[key] as? Int) != nil) {
            return dictionary[key] as! CMFeatureStyle.Style
        }
        return value;
    }
    
    /**
     Gets dictionary value for key.
     
     - Parameter key: key of value
     - Parameter value: default value of key
     - Returns: The Number.
     */
    internal func get(key: String, defaultNumber value: NSNumber) -> NSNumber {
        if ((dictionary[key] as? Int) != nil) {
            return dictionary[key] as! NSNumber
        }
        return value;
    }
    
    /**
     Gets dictionary value for key.
     
     - Parameter key: key of value
     - Parameter value: default value of key
     - Returns: The String.
     */
    internal func get(key: String, defaultString value: String) -> String {
        if ((dictionary[key] as? String) != nil) {
            return dictionary[key] as! String
        }
        return value;
    }
    
    /**
     Gets dictionary **pixels** value for key.
     
     - Parameter key: key of value
     - Parameter value: default value of key
     - Returns: The **pixels** String.
     */
    internal func get(key: String, defaultPixels value: String) -> String {
        if ((dictionary[key] as? String) != nil) {
            return dictionary[key] as! String
        }
        return value;
    }
    
    /**
     Gets dictionary value for key.
     
     - Parameter key: key of value
     - Parameter value: default value of key
     - Returns: The Bool.
     */
    internal func get(key: String, defaultBool value: Bool) -> Bool {
        if ((dictionary[key] as? Bool) != nil) {
            return dictionary[key] as! Bool
        }
        return value;
    }
    
    /**
     Gets dictionary value for key.
     
     - Parameter key: key of value
     - Parameter value: default value of key
     - Returns: The Any.
     */
    internal func get(key: String, defaultAny value: Any) -> Any {
        if dictionary[key] != nil {
            return dictionary[key]!
        }
        return value;
    }
    
    /**
     Gets dictionary **Pixels Array** value for key.
     
     - Parameter key: key of value
     - Parameter value: default value of key
     - Returns: The **Pixels Array**.
     */
    internal func get(key: String, defaultPixelsArray value: [String]) -> [String] {
        if ((dictionary[key] as? [String]) != nil) {
            return dictionary[key] as! [String]
        }
        return value;
    }
    
    /**
     Gets dictionary **JSONable** value for key.
     
     - Parameter key: key of value
     - Parameter value: default value of key
     - Returns: The **JSONable** Optional.
     */
    internal func get(key: String, defaultJSONable value: JSONable? ) -> JSONable? {
        if (dictionary[key] as? Dictionary<String, Any>) != nil  {
            return JSONable(dictionary: dictionary[key] as! Dictionary<String, Any>)
        }
        return value
    }
    
    /**
     Gets dictionary **JSONable** value for key.
     
     - Parameter key: key of value
     - Returns: The Any optional.
     */
    internal func get(key: String) -> Any? {
        if dictionary[key] != nil {
            return dictionary[key]
        }
        return nil
    }
    
    /**
     Updates the value stored in the dictionary for the given key.
     Called update() after sets value.
     
     - Parameter key: key of value
     - Parameter value: **Pixels Array** optional value
     */
    internal func set(key: String, pixelsArray value: [String]?){
        var array = value
        if array == nil {
            self.dictionary.removeValue(forKey: key)
        }else{
            for i in 0 ..< array!.count  {
                var v = array![i]
                if !v.hasSuffix("px"){
                    v = v + "px"
                    array!.remove(at: i)
                    array!.insert(v, at: i)
                }
            }
            
            self.dictionary.updateValue(array!, forKey: key)
        }
        
        // fem l'update pq el pare s'enteri dels canvis.
        self.update()
    }
    
    /**
     Updates the value stored in the dictionary for the given key.
     Called update() after sets value.
     
     - Parameter key: key of value
     - Parameter value: **Pixel** optional value
     */
    internal func set(key: String, pixels value: String?){
        if value == nil {
            self.dictionary.removeValue(forKey: key)
        }else{
            var v = value
            if !v!.hasSuffix("px"){
                v = v! + "px"
            }
            
            self.dictionary.updateValue(v!, forKey: key)
        }
        
        // fem l'update pq el pare s'enteri dels canvis.
        self.update()
    }
    
    /**
     Updates the value stored in the dictionary for the given key.
     Called update() after sets value.
     
     - Parameter key: key of value
     - Parameter value: Any optional value
     */
    internal func set(key: String, value: Any?){
        if value == nil {
            self.dictionary.removeValue(forKey: key)
            
        }else if (value as? JSONable) != nil {
            self.dictionary.updateValue( (value as! JSONable).dictionary, forKey: key)
            
        }else if (value as? CMFeatureStyle.Style) != nil {
            self.dictionary.updateValue((value as! CMFeatureStyle.Style).rawValue, forKey: key)
            
        }else if (value as? CMFontStyle.Style) != nil {
            self.dictionary.updateValue((value as! CMFontStyle.Style).rawValue, forKey: key)
            
        }else if (value as? CMFontStyle.Transform) != nil {
            self.dictionary.updateValue((value as! CMFontStyle.Transform).rawValue, forKey: key)
            
        }else if (value as? CMFontStyle.Weight) != nil {
            self.dictionary.updateValue((value as! CMFontStyle.Weight).rawValue, forKey: key)
            
        }else if (value as? CMLabelStyle.Anchor) != nil {
            self.dictionary.updateValue((value as! CMLabelStyle.Anchor).rawValue, forKey: key)
            
        }else{
            self.dictionary.updateValue(value!, forKey: key)
        }
        
        // fem l'update per el pare.
        self.update()
    }
}
