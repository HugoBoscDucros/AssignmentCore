//
//  Vehicle.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 21/06/2022.
//

import Foundation


public protocol Vehicle {
    var qrURL:String {get}
    var color:String {get}
    var identificationCode:String {get}
}

extension Vehicle {
    
    var colorTag:ColorTag {
        return ColorTag(value: color)
    }
}
