import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FuelEntry.date, order: .forward) private var entries: [FuelEntry]
    @StateObject private var viewModel = FuelViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if entries.isEmpty {
                    VStack {
                        Image(systemName: "chart.pie")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                            .padding()
                        Text("No Data Available")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 24) {
                            
                            // Summary Cards
                            let stats = viewModel.calculateTotalStats(entries: entries)
                            
                            HStack(spacing: 16) {
                                StatBox(title: "Avg Efficiency", value: String(format: "%.1f km/L", stats.avgEfficiency))
                                StatBox(title: "Total Spent", value: String(format: "$%.2f", stats.totalCost))
                            }
                            .padding(.horizontal)
                            
                            // Chart Section
                            VStack(alignment: .leading) {
                                Text("Fuel Cost Over Time")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                
                                Chart {
                                    ForEach(entries) { entry in
                                        BarMark(
                                            x: .value("Date", entry.date, unit: .day),
                                            y: .value("Cost", entry.totalPrice)
                                        )
                                        .foregroundStyle(Color.green.gradient)
                                        .cornerRadius(4)
                                    }
                                }
                                .frame(height: 250)
                                .padding()
                                .background(Color(UIColor.secondarySystemBackground).opacity(0.3))
                                .cornerRadius(16)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle("Statistics")
        }
    }
}

struct StatBox: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(value)
                .font(.title3)
                .bold()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.secondarySystemBackground).opacity(0.3))
        .cornerRadius(12)
    }
}

#Preview {
    StatisticsView()
}
