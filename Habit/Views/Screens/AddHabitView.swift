//
//  AddHabitView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI
import MapKit
import Combine

struct AddHabitView: View {
    @EnvironmentObject var habitVM: HabitViewModel
    
    // Habit Settings
    @State private var name: String = ""
    @State private var goal: Int = 0
    @State private var units: String = ""
    @State private var selectedDays: Set<Weekday> = []
    @State private var selectedTime = Date.now
    @State private var selectedTime2 = Date.now
    @State private var selectedHabitType: HabitType = .countHabit
    @State private var selectedGeofence: GeofenceRegion = GeofenceRegion(center: CLLocationCoordinate2D(), radius: 10, identifier: "Dummy")
    
    // UI
    @State private var mapSearch: String = ""
    @State private var isMapPresented = false
    
    func addCorrectHabit() {
        
        var habit: Habit
        
        switch selectedHabitType {
        case .habit:
            habit = Habit(name: name)
        case .countHabit:
            habit = CountHabit(name: name, goal: goal)
        case .timedHabit:
            print("HEYYYY DOENS'T WORK YET")
            habit = Habit(name: name)
        case .geofencedCountHabit:
            habit = GeofencedCountHabit(name: name, region: selectedGeofence, goal: goal)
        case .geofencedTimeHabit:
            print("HEYYYY DOENS'T WORK YET")
            habit = Habit(name: name)
        }
        
        habitVM.addHabit(habit)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack {
                    HStack {
                        Picker("Habit Type", selection: $selectedHabitType) {
                            ForEach(HabitType.allCases, id: \.self) { habitType in
                                Text("\(habitType.name)").tag(habitType)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding(8)
                        .foregroundStyle(.white)
                        .background(Theme.Color.gray800)
                        .cornerRadius(16)
                    }.padding(.vertical)
                    VStack(spacing: 24) {
                        VStack(alignment: .leading) {
                            Text("NAME")
                                .foregroundStyle(Theme.Color.gray400)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            TextField("What's the habit?", text: $name)
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
                            HStack {
                                TextField("ex. 3 times", value: $goal, formatter: NumberFormatter())
                                    .padding()
                                    .background(Theme.Color.gray900)
                                    .foregroundColor(Theme.Color.gray400)
                                    .cornerRadius(8)
                                    .padding(.horizontal, 4)
                                    .keyboardType(.numberPad)
                                TextField("Times", value: $units, formatter: NumberFormatter())
                                    .padding()
                                    .background(Theme.Color.gray900)
                                    .foregroundColor(Theme.Color.gray400)
                                    .cornerRadius(8)
                                    .padding(.horizontal, 4)
                                    .keyboardType(.numberPad)
                            }
                            
                        }
                        VStack(alignment: .leading) {
                            Text("DAYS")
                                .foregroundStyle(Theme.Color.gray400)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            HStack {
                                ForEach(Weekday.allCases, id: \.self) { day in
                                    Button(action: {
                                        if selectedDays.contains(day) {
                                            selectedDays.remove(day)
                                        } else {
                                            selectedDays.insert(day)
                                        }
                                    }) {
                                        Text(day.shortName)
                                            .padding()
                                            .background(selectedDays.contains(day) ? Theme.Color.blue600 : Theme.Color.gray700) // Adjust for selected/unselected
                                            .foregroundColor(selectedDays.contains(day) ? Color.white : Theme.Color.gray200)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                        if selectedHabitType == .timedHabit || selectedHabitType == .geofencedTimeHabit {
                            
                            VStack() {
                                DatePicker("Start time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                                    .padding(.horizontal)
                                    .foregroundColor(.white)
                                DatePicker("End time", selection: $selectedTime2, displayedComponents: .hourAndMinute)
                                    .padding(.horizontal)
                            }
                        }
                        if selectedHabitType == .geofencedTimeHabit || selectedHabitType == .geofencedCountHabit {
                            VStack() {
                                HStack {
                                    Text("AUTO LOCATION TRACKING")
                                        .foregroundStyle(Theme.Color.gray400)
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                Button(action: {
                                    isMapPresented.toggle()
                                }) {
                                    Image(systemName: "map")
                                    Text("Choose Location")
                                }
                                .padding()
                                .foregroundStyle(.blue)
                                .cornerRadius(16)
                                .fontWeight(.bold)
                            }
                        }
                    }.padding(.top)
                }
                Spacer()
            }.padding()
            Button(action: {
                addCorrectHabit()
            }) {
                Text("ADD HABIT")
                    .fontWeight(.bold)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 64)
                    .background(Theme.Color.blue600)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
            .padding(.vertical, 48)
            if isMapPresented {
                SearchableMap(isPresented: $isMapPresented, textFieldPlaceHolder: "Search...", search: $mapSearch, onSelectResult: {
                    _ in
                }, selectedGeofence: $selectedGeofence)
            }
        }
    }
}


#Preview {
    AddHabitView()
        .previewSetup()
}
