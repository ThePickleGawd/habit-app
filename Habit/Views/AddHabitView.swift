//
//  AddHabitView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI

struct AddHabitView: View {
    @State private var name: String = ""
    
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
