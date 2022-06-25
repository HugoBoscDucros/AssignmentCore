//
//  ColorTag.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 25/06/2022.
//

import Foundation

public enum ColorTag:String, CaseIterable {
    case redGreen = "RedGreen"
    case blueRed = "BlueRed"
    case pinkYellow = "PinkYellow"
    case yellowBlue = "YellowBlue"
    case unknown
    
    public init(value: String) {
        self = ColorTag.init(rawValue: value) ?? .unknown
    }
}
