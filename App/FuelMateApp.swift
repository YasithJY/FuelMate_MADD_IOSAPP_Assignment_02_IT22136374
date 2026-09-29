import SwiftUI
import SwiftData

@main
struct FuelMateApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                // We will configure SwiftData model container here later
                .preferredColorScheme(.dark) // Based on the dark charcoal base requirement
        }
    }
}
