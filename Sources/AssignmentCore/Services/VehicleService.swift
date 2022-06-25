//
//  VehicleService.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 22/06/2022.
//

import Foundation

///Class resonsible for ownership, syncronisation and observer notification of filtered data from AssignmentUtility framework
public class VehicleService:DataSyncObserver, FileringObserver {
    
    //to facilitate unit testing we should depending on protocol insted of concreate types for services
    unowned var filteringService:FilteringService
    unowned var syncDataService:DataSyncService
    
    weak var dataObserver:DataSyncObserver? {
        didSet {
            dataObserver?.didUpdate(filteredVehicles)
        }
    }
    
    weak var filterObserver:FileringObserver? {
        didSet {
            filterObserver?.didUpdate(filteringColorTags)
        }
    }
    
    var filteredVehicles = [Vehicle]() {
        didSet {
            dataObserver?.didUpdate(filteredVehicles)
        }
    }
    
    
    //MARK: - shortcuts
    
    var vehicles:[Vehicle] {
        return syncDataService.vehicles
    }
    
    var filteringColorTags:Set<ColorTag> {
        return filteringService.colorTags
    }
    
    
    //MARK: - init
    
    init(filteringService:FilteringService, syncDataService:DataSyncService) {
        self.syncDataService = syncDataService
        self.filteringService = filteringService
        self.syncDataService.observer = self
        self.filteringService.observer = self
    }
    
    
    //MARK: - Public methods
    
    ///Start server data synchronisation with regular server calls
    public func start() {
        self.syncDataService.start()
    }
    
    public func update(filteringColorTags:Set<ColorTag>) {
        self.filteringService.update(filteringColorTags)
    }
    
    
    //MARK: - VehicleSyncDataObserver
    
    public func didUpdate(_ vehicles: [Vehicle]) {
        self.filteredVehicles = filteringService.filter(vehicles)
    }
    
    public func didFailUpdateData(_ error: Error) {
        self.dataObserver?.didFailUpdateData(error)
    }
    
    
    //MARK: - VehicleFiltzeringObserver
    
    public func didUpdate(_ filters: Set<ColorTag>) {
        self.filteredVehicles = filteringService.filter(vehicles)
        filterObserver?.didUpdate(filters)
    }
    
}
