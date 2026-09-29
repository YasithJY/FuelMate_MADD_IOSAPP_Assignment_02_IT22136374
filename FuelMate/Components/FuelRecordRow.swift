import SwiftUI

struct FuelRecordRow: View {
    var entry: FuelEntry
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(entry.stationName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(entry.formattedDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 6) {
                Text(String(format: "$%.2f", entry.totalPrice))
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(String(format: "%.1f L", entry.fuelAmount))
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 8)
    }
}
