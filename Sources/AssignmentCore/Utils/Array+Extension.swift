//
//  Array+Extension.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 21/06/2022.
//

import Foundation

extension Array where Element==DottVehicle {
    
    ///Method that is responsible for parsing to `[DottVehicle]`  from AssignmentUtility framework data serialization
    static func decode(_ data:Data) -> Self? {
        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
              let array = json["vehicles"] as? [[String:Any]]
        else {return nil}
        var vehicles = Self()
        for value in array {
            if let vehicle = try? DottVehicle.decode(JSONData: value) {
                vehicles.append(vehicle)
            }
        }
        return vehicles
        
    }
}
