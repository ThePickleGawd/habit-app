//
//  CountHabit.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import Foundation

class CountHabit : Habit {
    @Published var progress: Int = 0
    @Published var goal: Int
    
    init(name: String, goal: Int) {
        self.goal = goal
        
        super.init(name: name)
    }
    
    override func getProgressString() -> String {
        return "\(self.progress) / \(self.goal)"
    }
    
    override func actionButtonClicked() {
        if (self.progress < self.goal) {
            self.progress += 1
        }
    }
}
