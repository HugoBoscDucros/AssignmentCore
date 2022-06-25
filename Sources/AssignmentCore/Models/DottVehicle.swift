//
//  DottVehicle.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 25/06/2022.
//

import Foundation


public struct DottVehicle:Vehicle,Codable {
    public var qrURL:String
    public var color:String
    public var identificationCode:String
}

extension DottVehicle {
    ///Method that is responsible for parsing `DottVehicle` model from AssignmentUtiliy framework data json serialization
    static func decode(JSONData:[String:Any]) throws -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let data = try JSONSerialization.data(withJSONObject: JSONData)
            let object = try decoder.decode(self, from: data)
            return object
        } catch {
            throw error
        }
    }
}
