//
//  ContentView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @EnvironmentObject var habitVM: HabitViewModel
    @EnvironmentObject var locationListener: LocationListener
    
    @State var swipeOffset: CGFloat = 0
        
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house")
            }
            
            AddHabitView().tabItem {
                Image(systemName: "plus.app")
            }
            
            AnalyticsView(habitVM: habitVM).tabItem {
                Image(systemName: "chart.xyaxis.line")
            }
        }.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}



#Preview {
    ContentView().previewSetup()
}
