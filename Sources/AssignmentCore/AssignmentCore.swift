//
//  AssignmentCore.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 22/06/2022.
//

import Foundation

///Class responsible for high level services ownership, context management and dependency injections in class instances
public class AssignmentCore {
    
    public init(){}
    
    private lazy var dataSyncService = {
        DataSyncService()
    }()
    
    private lazy var filteringService: FilteringService = {
        let service = FilteringService()
        service.store = self.store
        return service
    }()
    
    public lazy var vehicleService = {
        VehicleService(filteringService: filteringService, syncDataService: dataSyncService)
    }()
    
    private lazy var store:Store = {
        UserDefaultStore()
    }()
    
    public func set(vehicleObserver:DataSyncObserver) {
        self.vehicleService.start()
        self.vehicleService.dataObserver = vehicleObserver
    }
    
    public func set(filteringObserver:FileringObserver) {
        self.vehicleService.filterObserver = filteringObserver
    }
    
}
