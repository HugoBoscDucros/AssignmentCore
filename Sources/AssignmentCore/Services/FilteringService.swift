//
//  FilteringService.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 21/06/2022.
//

import Foundation

///The methods that an object adopts to be notified of filters update
public protocol FileringObserver:AnyObject {
    func didUpdate(_ filters:Set<ColorTag>)
}

///A class responsible for ownership, synchronisation and storage logic of filtering data. It provide methods for filtering data
public class FilteringService {
    
    
    public var colorTags:Set<ColorTag> = Set(ColorTag.allCases) {
        didSet {
            store?.store(tags: colorTags)
            observer?.didUpdate(colorTags)
        }
    }
    
    ///Object that will be notify of filter updates
    public weak var observer:FileringObserver? = nil {
        didSet {
            observer?.didUpdate(colorTags)
        }
    }
    
    public weak var store:Store? = nil {
        didSet {
            loadTagsifExist()
        }
    }
    
    private func loadTagsifExist() {
        guard let tags = store?.getTags() else {return}
        self.colorTags =  tags
    }
    
    
    ///Method for filtering data using the owned filtering data
    public func filter(_ vehicles:[Vehicle]) -> [Vehicle] {
        return vehicles.filter { vehicle in
            self.colorTags.contains(vehicle.colorTag)
        }
    }
    
    public func add(_ tag:ColorTag) {
        _ = self.colorTags.update(with: tag)
    }
    
    public func update(_ tags:Set<ColorTag>) {
        self.colorTags = tags
    }
    
    public func remove(_ tag:ColorTag) {
        _ = self.colorTags.remove(tag)
    }
    
}
