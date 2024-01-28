//
//  GeofencedHabit.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation
import CoreLocation

class GeofencedCountHabit : CountHabit {
    @Published var region: GeofenceRegion
    
    init(name: String, id: UUID = UUID(),creationDate: Date = Date(), activeDays: Set<Weekday> = [], region: GeofenceRegion, goal: Int, progress: Int = 0) {
        self.region = region
        
        super.init(name: name, id: id, creationDate: creationDate, activeDays: activeDays, goal: goal, progress: progress)
    }
    
    override func toHabitData() -> HabitData {
        return HabitData(habitType: .geofencedCountHabit, name: name, id: id, creationDate: creationDate, progress: progress, goal: goal, region: region)
    }
}
