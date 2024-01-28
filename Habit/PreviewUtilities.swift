import SwiftUI

// Custom view modifier for setting up preview environment
struct PreviewEnvironment: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environmentObject(HabitViewModel())
            .environmentObject(LocationListener())
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            // Add other environment objects or configurations here
    }
}

extension View {
    func previewSetup() -> some View {
        modifier(PreviewEnvironment())
    }
}
