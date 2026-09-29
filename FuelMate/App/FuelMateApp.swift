import SwiftUI
import SwiftData

@main
struct FuelMateApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: FuelEntry.self)
    }
}
