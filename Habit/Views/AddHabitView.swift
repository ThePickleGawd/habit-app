//
//  AddHabitView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI

struct Day: Identifiable, Hashable {
    let id: UUID
    let name: String
}

struct AddHabitView: View {
    @State private var name: String = ""
    @State private var selectedDays = Set<UUID>()
    @State private var selectedTime = Date.now
    
    private var daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    private var days: [Day]
    
    init() {
            days = daysOfWeek.map { Day(id: UUID(), name: $0) }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    IconButtonView(systemName: "xmark", action: {})
                    Spacer()
                    Text("New Habit")
                        .fontWeight(.bold)
                        .foregroundStyle(Theme.Color.gray200)
                        .font(.title2)
                    Spacer()
                    IconButtonView(systemName: "checkmark", action: {})
                }.padding(.vertical)
                VStack(spacing: 24) {
                    VStack(alignment: .leading) {
                        Text("NAME")
                            .foregroundStyle(Theme.Color.gray400)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        TextField("placeholder", text: $name)
                            .padding()
                            .background(Theme.Color.gray900)
                            .foregroundColor(Theme.Color.gray400)
                            .cornerRadius(8)
                            .padding(.horizontal, 4)
                        
                    }
                    VStack(alignment: .leading) {
                        Text("GOAL")
                            .foregroundStyle(Theme.Color.gray400)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        TextField("placeholder", text: $name)
                            .padding()
                            .background(Theme.Color.gray900)
                            .foregroundColor(Theme.Color.gray400)
                            .cornerRadius(8)
                            .padding(.horizontal, 4)
                        
                    }
                    VStack(alignment: .leading) {
                        Text("DAYS")
                            .foregroundStyle(Theme.Color.gray400)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        HStack {
                            ForEach(days, id: \.self) { day in
                                Button(action: {
                                    if selectedDays.contains(day.id) {
                                        selectedDays.remove(day.id)
                                    } else {
                                        selectedDays.insert(day.id)
                                    }
                                }) {
                                    Text(day.name)
                                        .padding()
                                        .background(Theme.Color.gray700)
                                        .foregroundColor(Theme.Color.gray200)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                    VStack() {
                        DatePicker("Select what time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    }.padding()
                        .foregroundColor(.white)
                }
                Spacer()
            }.padding()
            Button(action: {
                
            }) {
                Text("ADD HABIT")
                    .fontWeight(.bold)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 64)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
        }
    }
}

#Preview {
    AddHabitView().background(Theme.Color.gray800)
}
