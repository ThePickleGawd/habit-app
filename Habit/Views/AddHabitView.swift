//
//  AddHabitView.swift
//  Habit
//
//  Created by Dylan Lu on 1/27/24.
//

import SwiftUI
import MapKit
import Combine

struct Day: Identifiable, Hashable {
    let id: UUID
    let name: String
}

struct AddHabitView: View {
    @State private var name: String = ""
    @State private var selectedDays = Set<UUID>()
    @State private var selectedTime = Date.now
    @State private var isMapPresented = false
    
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
                                        .background(selectedDays.contains(day.id) ? Theme.Color.blue600 : Theme.Color.gray700) // Selected color
                                        .foregroundColor(selectedDays.contains(day.id) ? Color.white : Theme.Color.gray200) // Adjust text color accordingly
                                        .cornerRadius(8)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                    VStack() {
                        DatePicker("Start time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    }.padding(.top)
                        .padding(.horizontal)
                        .foregroundColor(.white)
                    VStack() {
                        DatePicker("End time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    }.padding(.horizontal)
                        .foregroundColor(.white)
                    VStack {
                        Button(action: {
                            isMapPresented.toggle()
                        }) {
                            Image(systemName: "map")
                            Text("Choose Location")
                        }
                        .sheet(isPresented: $isMapPresented) {
                            MapView()
                        }
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
                    .background(Theme.Color.blue600)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
        }
        
    }
}

struct MapView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var searchQuery = ""
    @State private var searchResults: [MKLocalSearchCompletion] = []
    @State private var selectedMapItem: MKMapItem?
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(query: $searchQuery, searchResults: searchDelegate)
                
                Map(coordinateRegion: $region, showsUserLocation: true)
                    .onAppear {
                        // Setup stuff if needed
                    }
                    .onChange(of: selectedMapItem) {  newItem in
                        if let newItem = newItem {
                            region.center = newItem.placemark.coordinate
                        }
                    }
                    .navigationBarItems(
                        trailing: Button("Done") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                    .navigationBarTitle("Map", displayMode: .inline)
            }
            .padding()
        }
    }
}

struct SearchBar: View {
    @Binding var query: String
    @ObservedObject var searchDelegate: SearchDelegate
    
    init(query: Binding<String>, searchResults: Binding<[MKLocalSearchCompletion]>) {
        _query = query
        _searchDelegate = ObservedObject(initialValue: SearchDelegate())
    }
    
    var body: some View {
        HStack {
            TextField("Search for a location", text: $query)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Search") {
                performSearch()
            }
        }
        .padding()
    }
    private func performSearch() {
        let completer = MKLocalSearchCompleter()
        completer.delegate = searchDelegate
        completer.queryFragment = query
    }
}

class SearchDelegate: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults: [MKLocalSearchCompletion]
    
    override init() {
        super.init()
    }
    
    init(searchResults: MKLocalSearchCompletion) {
        _searchResults = searchResults
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            let completions = completer.results
            self.searchResults = completer.results
        }
    }
}

#Preview {
    AddHabitView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
