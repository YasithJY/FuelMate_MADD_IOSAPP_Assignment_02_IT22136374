import SwiftUI
import MapKit
import SwiftData

struct MapView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var entries: [FuelEntry]
    
    // Default region (centered vaguely)
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                Map {
                    ForEach(entries) { entry in
                        // Only show entries with valid coordinates
                        if let lat = entry.latitude, let lon = entry.longitude {
                            Annotation(entry.stationName, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon)) {
                                VStack {
                                    Image(systemName: "fuelpump.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.green)
                                        .background(Circle().fill(Color.black))
                                    
                                    Text(String(format: "$%.2f", entry.totalPrice))
                                        .font(.caption)
                                        .bold()
                                        .padding(4)
                                        .background(Color.black.opacity(0.7))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .ignoresSafeArea(edges: .top)
            }
            .navigationTitle("Stations")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    MapView()
}
