//
//  HabitHistoryEntry.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation

struct HabitHistoryEntry: Identifiable {
    var id = UUID()
    var date: Date
    var completionStatus: Bool
    var additionalData: [String: Any] // Can store extra data like location for geofenced habits.
}
