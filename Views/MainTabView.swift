import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Text("Dashboard")
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            Text("Records")
                .tabItem {
                    Label("Records", systemImage: "list.clipboard.fill")
                }
            
            Text("Statistics")
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
            
            Text("Map")
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
        }
        .tint(.green) // Use strong green accent for the app
    }
}

#Preview {
    MainTabView()
}
