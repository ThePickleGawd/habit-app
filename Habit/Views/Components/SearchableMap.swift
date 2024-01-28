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
            Map(position: $viewModel.position, interactionModes: .all) {
                if let selectedSearchLocation = viewModel.selectedSearchLocation {
                    Marker(selectedSearchLocation.name, systemImage: "fork.knife", coordinate: selectedSearchLocation.coordinate)
                        .tint(.pink)
                    
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
