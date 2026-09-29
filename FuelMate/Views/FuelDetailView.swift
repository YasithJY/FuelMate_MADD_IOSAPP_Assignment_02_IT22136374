import SwiftUI
import SwiftData

struct FuelDetailView: View {
    var entry: FuelEntry
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Header Card
                    VStack(spacing: 12) {
                        Image(systemName: "fuelpump.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                            .padding(.bottom, 8)
                        
                        Text(entry.stationName)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text(entry.formattedDate)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 30)
                    .background(Color(UIColor.secondarySystemBackground).opacity(0.3))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Details Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        DetailItem(title: "Fuel Amount", value: String(format: "%.1f L", entry.fuelAmount), icon: "drop.fill")
                        DetailItem(title: "Total Cost", value: String(format: "$%.2f", entry.totalPrice), icon: "dollarsign.circle.fill")
                        DetailItem(title: "Price per Litre", value: String(format: "$%.2f / L", entry.pricePerLitre), icon: "tag.fill")
                        DetailItem(title: "Odometer", value: String(format: "%.0f km", entry.odometer), icon: "speedometer")
                    }
                    .padding(.horizontal)
                    
                    if !entry.notes.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Text(entry.notes)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground).opacity(0.3))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
        }
        .navigationTitle("Record Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailItem: View {
    var title: String
    var value: String
    var icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.green)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(value)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground).opacity(0.3))
        .cornerRadius(12)
    }
}
