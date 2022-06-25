//
//  Store.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 21/06/2022.
//

import Foundation

public protocol Store:AnyObject {
    func store(tags:Set<ColorTag>)
    func getTags() -> Set<ColorTag>?
    func removeTags()
    
}

class UserDefaultStore:Store {
    
    var userDefault = UserDefaults.standard
    let tagsStoringKey = "VehicleFilteringTags"
    
    func store(tags: Set<ColorTag>) {
        let stringTags = tags.map {$0.rawValue}
        self.userDefault.set(stringTags, forKey: tagsStoringKey)
    }
    
    func getTags() -> Set<ColorTag>? {
        guard let object = self.userDefault.object(forKey: tagsStoringKey),
              let stringTags = object as? [String]
        else {
            return nil
            
        }
        return Set(stringTags.map({ColorTag(value: $0)}))
    }
    
    func removeTags() {
        self.userDefault.removeObject(forKey: tagsStoringKey)
    }
    
    
}
