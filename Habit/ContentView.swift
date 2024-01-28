//
//  ContentView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @EnvironmentObject var locationListener: LocationListener
    @State var swipeOffset: CGFloat = 0
        
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house")
                Text("Home")
            }.preferredColorScheme(.dark)
            AddHabitView().tabItem {
                Image(systemName: "plus.app")
                Text("Add Habit")
            }.preferredColorScheme(.dark)
            
            AnalyticsView().tabItem {
                Image(systemName: "chart.xyaxis.line")
                Text("Analytics")
            }.preferredColorScheme(.dark)
        }
    }
}



#Preview {
    ContentView().background(Theme.Color.gray800)
}
