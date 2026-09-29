import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            RecordsView()
                .tabItem {
                    Label("Records", systemImage: "list.clipboard.fill")
                }
            
            StatisticsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
            
            MapView()
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
