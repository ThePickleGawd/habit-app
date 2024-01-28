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
    
    init(name: String, id: UUID = UUID(),creationDate: Date = Date(), activeDays: Set<Weekday> = [], region: GeofenceRegion, completed: Bool = false) {
        self.region = region
        self.completed = completed
        
        super.init(name: name, id: id, creationDate: creationDate, activeDays: activeDays)
    }
    
    override func getProgressString() -> String {
        return "\(self.completed ? "Completed" : "Not completed")"
    }
    
    override func actionButtonClicked() {
        self.completed = true
    }
    
    override func toHabitData() -> HabitData {
        return HabitData(habitType: .geofencedHabit, name: name, id: id, creationDate: creationDate, region: region, completed: completed)
    }
}
