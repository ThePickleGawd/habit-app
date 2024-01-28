//
//  HabitSettingsView.swift
//  Habit
//
//  Created by Dylan Lu on 1/28/24.
//

import SwiftUI

struct HabitSettingsView: View {
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool> = .constant(false)) {
            self._isPresented = isPresented
        }
    
    var body: some View {
        VStack {
            HStack {
                Text("Habit Name")
                    .font(.system(size: 24))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                
                Spacer()
                
                IconButtonView(systemName: "pencil", action: {
                    
                })
            }
            .padding(24)
            Spacer()
        }
    }
}

#Preview {
    HabitSettingsView()
        .previewSetup()
}
