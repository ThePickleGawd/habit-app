import MapKit
import SwiftUI

public struct SearchableMap: View {
    @ObservedObject private var viewModel: SearchableMapViewModel
    @Binding var isPresented: Bool
    
    public init(isPresented: Binding<Bool>, textFieldPlaceHolder: String, search: Binding<String>, onSelectResult: @escaping (SearchResult) -> Void) {
        self.viewModel = SearchableMapViewModel(searchService: SearchLocationServiceFactory.make(), searchPlaceHolder: textFieldPlaceHolder, onSelectResult: onSelectResult)
        self._isPresented = isPresented
    }
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            MapReader { proxy in
                Map(position: $viewModel.position, interactionModes: .all) {
                    if let selectedSearchLocation = viewModel.selectedSearchLocation {
                        Marker(selectedSearchLocation.name, systemImage: "mappin.circle.fill", coordinate: selectedSearchLocation.coordinate)
                            .tint(.red)
                    } else {
                        Marker("Custom Location", systemImage: "mappin.circle.fill", coordinate: viewModel.tapCoordinate)
                            .tint(.red)
                    }
                }
                .sheet(isPresented: .constant(true)) {
                    SearchSheet(
                        textFieldPlaceHolder: viewModel.searchPlaceHolder,
                        search: $viewModel.searchQuery,
                        selectedPresentationDetent: $viewModel.selectedPresentationDetent,
                        results: viewModel.searchResults,
                        didSelectResult: viewModel.didSelectResult
                    )
                }
                .ignoresSafeArea()
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        moveMap(to: coordinate)
                    }
                }
                
                HStack {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancel")
                            .padding()
                            .background(Theme.Color.gray600.opacity(0.9))
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Done")
                            .padding()
                            .background(Theme.Color.gray600.opacity(0.9))
                            .cornerRadius(16)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private func moveMap(to coordinate: CLLocationCoordinate2D) {
        withAnimation(.easeInOut(duration: 0.3)) {
            viewModel.tapOnMap(coordinate: coordinate)
        }
    }
}
