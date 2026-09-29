import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FuelEntry.date, order: .reverse) private var entries: [FuelEntry]
    @StateObject private var viewModel = FuelViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Good Morning,")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Text("My Vehicle")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                        .padding(.top)
                        
                        // Statistics Grid
                        let stats = viewModel.calculateTotalStats(entries: entries)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            FuelStatCard(title: "Avg Efficiency", value: String(format: "%.1f km/L", stats.avgEfficiency), icon: "leaf.fill", color: .green)
                            FuelStatCard(title: "Total Cost", value: String(format: "$%.2f", stats.totalCost), icon: "dollarsign.circle.fill", color: .orange)
                            FuelStatCard(title: "Total Distance", value: String(format: "%.0f km", stats.totalDistance), icon: "road.lanes", color: .blue)
                            FuelStatCard(title: "Total Fuel", value: String(format: "%.1f L", stats.totalFuel), icon: "fuelpump.fill", color: .purple)
                        }
                        .padding(.horizontal)
                        
                        // Recent Records
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Recent Records")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.white)
                                Spacer()
                                NavigationLink(destination: RecordsView()) {
                                    Text("See All")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            
                            if entries.isEmpty {
                                Text("No fuel records yet. Add one to get started.")
                                    .foregroundColor(.gray)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .center)
                            } else {
                                ForEach(entries.prefix(3)) { entry in
                                    NavigationLink(destination: FuelDetailView(entry: entry)) {
                                        FuelRecordRow(entry: entry)
                                    }
                                    .padding(.horizontal)
                                    Divider().background(Color.gray.opacity(0.3)).padding(.horizontal)
                                }
                            }
                        }
                        
                        // Add Fuel Button
                        NavigationLink(destination: AddFuelView()) {
                            PrimaryButton(title: "Add Fuel", icon: "plus.circle.fill", action: {})
                                .disabled(true)
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    DashboardView()
}
