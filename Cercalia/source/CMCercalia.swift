//
//  CMCercalia.swift
//  CercaliaSDK
//
//  Created by David Comas on 31/5/17.
//
//

import Foundation

/**
 Cercalia Configuration:
 
 ### Example: ###
 
 ````
 // Add cercalia api key:
 CMCercalia.instance.apiKey = API_KEY
 ````
 */
public class CMCercalia {

    /// Cercalia intance
    public static let instance: CMCercalia = CMCercalia()

    /// debug logger. True to enable debug log.
    public var debugLogger: Bool = false
    
    /// info logger. True to enable info log.
    public var infoLogger: Bool = true
    
    /// Cercalia API KEY
    public var apiKey: String?
    
}
