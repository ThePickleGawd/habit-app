//
//  HomeView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HabitViewModel()
    @State var showCalendar = false
    
    var body: some View {
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
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Habits")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal)
                ForEach(viewModel.habits, id: \.self) { habit in
                    HabitListItemView(habit: habit)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

#Preview {
    HomeView().preferredColorScheme(.dark)
}
