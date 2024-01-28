//
//  HabitViewModel.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation
import SwiftUI

class HabitViewModel: ObservableObject {
    @Published var habitHistorys: [HabitHistory] = []

    var geofenceDelegate: GeofenceSetupDelegate?


    init() {
        loadHabitHistorys()
    }
    
    func saveHabitHistorys() {
        do {
            let encoded = try JSONEncoder().encode(habitHistorys)
            UserDefaults.standard.set(encoded, forKey: "habitHistorys")
            
        } catch {
            print("Error saving habit historys: \(error)")
        }
    }

    func loadHabitHistorys() {
        if let historyData = UserDefaults.standard.data(forKey: "habitHistorys") {
            do {
                let savedHabitHistory = try JSONDecoder().decode([HabitHistory].self, from: historyData)
                self.habitHistorys = savedHabitHistory
            } catch {
                print("Error loading habit historys: \(error)")
            }
        }
    }

    // Create a new habit from the UI (with it's own HabitHistory)
    func addHabit(_ habit: Habit) {
        var history = HabitHistory()
        history.addHabit(habit: habit.toHabitData())
        habitHistorys.append(history)
        saveHabitHistorys()
        
        if(habit.toHabitData().habitType == .geofencedTimeHabit || habit.toHabitData().habitType == .geofencedCountHabit) {
            geofenceDelegate?.refreshGeofences()
        }
    }
    
    func appendHabit() {
        // TODO: useful for if we have a new day and want to add that to history array
    }

    func updateHabit(_ habit: Habit) {
        if let index = habitHistorys.firstIndex(where: { $0.getTodaysHabitData().id == habit.id }) {
            print("Trying to update \(habit.name)")
            let historyIndex = habitHistorys[index].history.count - 1 // Corrected index for history array
            if historyIndex >= 0 {
                habitHistorys[index].history[historyIndex] = habit.toHabitData()
                saveHabitHistorys()
            } else {
                print("Something is empty")
            }
        }
    }


    func deleteHabit(_ habit: Habit) {
        habitHistorys.removeAll { $0.getTodaysHabitData().id == habit.id }
        saveHabitHistorys()
        
        if(habit.toHabitData().habitType == .geofencedTimeHabit || habit.toHabitData().habitType == .geofencedCountHabit) {
            geofenceDelegate?.refreshGeofences()
        }
    }
}
