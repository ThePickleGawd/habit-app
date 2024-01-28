//
//  Habit.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation

struct Habit: Identifiable {
    var id = UUID()
    var title: String
    var creationDate: Date
}
