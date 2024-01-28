//
//  HomeView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var habitVM: HabitViewModel
    @EnvironmentObject var locationListener: LocationListener
    @State var showCalendar = false
    
    var body: some View {
        ScrollView {
            VStack() {
                HStack {
                    IconButtonView(systemName: "person", action: {
                        
                    })
                    Text("Today")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity)
                    IconButtonView(systemName: "calendar", action: {
                        showCalendar.toggle()
                    })
                    .sheet(isPresented: $showCalendar) {
                        Text("Hey")
                            .presentationDetents([.medium])
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                
                Text(locationListener.isInZone ? "Here" : "Not here")
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Habits")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.horizontal)
                    ForEach(habitVM.habitHistorys, id: \.self) { habitHistory in
                        HabitListItemView(habit: habitHistory.getTodaysHabit()!)
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
    }
}

#Preview {
    HomeView().previewSetup()
}
