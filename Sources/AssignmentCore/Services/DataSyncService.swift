//
//  VehiculeSyncService.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 20/06/2022.
//

import Foundation
import AssignmentUtility


///The methods that an object adopts to be notified of data update from AssignmentUtility framework
public protocol DataSyncObserver:AnyObject {
    func didUpdate(_ vehicles:[Vehicle])
    func didFailUpdateData(_ error:Error)
}

///A class responsible for data synchronisation with AssignmentUtility framework, parsing data to model and notify observer
public class DataSyncService {
    
    ///Object that will be notify of data updates
    public weak var observer:DataSyncObserver? = nil {
        didSet {
            observer?.didUpdate(vehicles)
        }
    }
    public var vehicles = [Vehicle]() {
        didSet {
            DispatchQueue.main.async { [self] in
                self.observer?.didUpdate(vehicles)
            }
        }
    }
    
    //MARK: - Exposed methods
    ///Start server data synchronisation with regular server calls
    public func start() {
        self.requestVehiculeData()
    }
    
    private func requestVehiculeData() {
        let sequence = AssignmentUtility.requestVehiclesData()
        _ = sequence.subscribe { event in
            switch event {
            case .next(let data):
                if let vehicles = [DottVehicle].decode(data) {
                    print("update vehicles")
                    self.vehicles = vehicles
                }
            case .completed:
                print("completed")
            case .error(let error):
                DispatchQueue.main.async {
                    self.observer?.didFailUpdateData(error)
                }
                print(error.localizedDescription)
                self.requestVehiculeData()
            }
        }
        
    }
    
}
