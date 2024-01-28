//
//  GeofencedHabit.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation
import CoreLocation

class GeofencedHabit : Habit {
    @Published var region: GeofenceRegion
    @Published var completed: Bool
    
    init(name: String, region: GeofenceRegion) {
        self.region = region
        self.completed = false
        
        super.init(name: name)
    }
    
    override func getProgressString() -> String {
        return "\(self.completed ? "Completed" : "Not completed")"
    }
    
    override func actionButtonClicked() {
        self.completed = true
    }
}
