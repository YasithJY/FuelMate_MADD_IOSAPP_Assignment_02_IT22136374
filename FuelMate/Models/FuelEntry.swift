import Foundation
import SwiftData
import CoreLocation

@Model
final class FuelEntry {
    var id: UUID
    var date: Date
    var fuelAmount: Double // in litres
    var totalPrice: Double
    var odometer: Double // in km
    var stationName: String
    var latitude: Double?
    var longitude: Double?
    var notes: String
    
    init(id: UUID = UUID(), date: Date = Date(), fuelAmount: Double, totalPrice: Double, odometer: Double, stationName: String, latitude: Double? = nil, longitude: Double? = nil, notes: String = "") {
        self.id = id
        self.date = date
        self.fuelAmount = fuelAmount
        self.totalPrice = totalPrice
        self.odometer = odometer
        self.stationName = stationName
        self.latitude = latitude
        self.longitude = longitude
        self.notes = notes
    }
    
    // MARK: - Computed Properties
    var pricePerLitre: Double {
        guard fuelAmount > 0 else { return 0 }
        return totalPrice / fuelAmount
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
