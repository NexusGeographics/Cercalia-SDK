//
//  CMObject.swift
//  CercaliaSDK
//
//  Created by Marc on 8/6/17.
//
//

import UIKit

public class CMObject:NSObject {
    private enum ObjTypes {
        case KeyValue
        case CodeName
        case Value
        case Intersection
        case Coords
        case Other
    }
    
    init(dic: NSDictionary) {
        super.init();
        
        for (key, value) in dic {
            let keyName = key as! String
            if (self.responds(to: NSSelectorFromString(keyName))){
                if(value is NSDictionary){
                    let objType = self.getType(key: keyName, dict: value as! NSDictionary);
                    
                    switch objType {
                        case ObjTypes.KeyValue:
                            let objValue = CMKeyValue(dic: value as! NSDictionary);
                            self.setValue(objValue, forKey: keyName);
                            break;
                        case ObjTypes.CodeName:
                            let objValue = CMCodeName(dic: value as! NSDictionary);
                            self.setValue(objValue, forKey: keyName);
                            break;
                        case ObjTypes.Value:
                            let objValue = CMValue(dic: value as! NSDictionary);
                            self.setValue(objValue, forKey: keyName);
                            break;
                        case ObjTypes.Coords:
                            let objValue = CMGe.Coords(dic: value as! NSDictionary);
                            self.setValue(objValue, forKey: keyName);
                            break;
                        case ObjTypes.Intersection:
                            let objValue = CMGe(dic: value as! NSDictionary);
                            self.setValue(objValue, forKey: keyName);
                            break;
                    default: break;
                    }
                }
                else if (value is Int) {
                    self.setValue(value as! Int, forKey: keyName)
                }
                else if (value is Double) {
                    self.setValue(value as! Int, forKey: keyName)
                }
                else if (value is String){
                    let keyValue: String = value as! String
                    self.setValue(keyValue, forKey: keyName)
                }
            }
        }
    }
    
    private func getType(key: String, dict: NSDictionary) -> ObjTypes{
        if (dict["id"] != nil){
            return ObjTypes.KeyValue;
        }
        else if (dict["code"] != nil){
            return ObjTypes.CodeName;
        }
        else if (dict["value"] != nil){
            return ObjTypes.Value;
        }
        else if (dict["x"] != nil){
            return ObjTypes.Coords;
        }
        else if (key == "intersection"){
            return ObjTypes.Intersection;
        }
        
        return ObjTypes.Other;
    }
}
