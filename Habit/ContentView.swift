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
            VStack(alignment: .center) {
                HStack(alignment: .center ) {
                    Image(systemName: "person.crop.circle").font(.system(size: 24))
                    Spacer()
                    Text("Today").font(.title)
                    Spacer()
                    Image(systemName: "gearshape").font(.system(size: 24))
                }
                .padding(.all)
                List {
                    Text("Habit 1")
                    Text("Habit 2")
                }
                
                
            }.tabItem {
                Image(systemName: "house")
            }
            AddHabitView().tabItem {
                Image(systemName: "plus.app")
            }
            
            VStack {
                
            }.tabItem {
                Image(systemName: "chart.line.uptrend.xyaxis")
            }
        }
    }
}



#Preview {
    ContentView().background(Theme.Color.gray800)
}
