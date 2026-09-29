import SwiftUI

class FuelViewModel: ObservableObject {
    
    // Calculates the fuel efficiency (km/L) between two entries
    func calculateEfficiency(currentOdometer: Double, previousOdometer: Double, fuelAmount: Double) -> Double {
        guard fuelAmount > 0, currentOdometer > previousOdometer else { return 0.0 }
        let distance = currentOdometer - previousOdometer
        return distance / fuelAmount
    }
    
    // Calculates total stats for the dashboard
    func calculateTotalStats(entries: [FuelEntry]) -> (avgEfficiency: Double, totalCost: Double, totalDistance: Double, totalFuel: Double) {
        guard !entries.isEmpty else { return (0, 0, 0, 0) }
        
        let totalCost = entries.reduce(0) { $0 + $1.totalPrice }
        let totalFuel = entries.reduce(0) { $0 + $1.fuelAmount }
        
        // Sort entries by odometer to find total distance
        let sorted = entries.sorted { $0.odometer < $1.odometer }
        var totalDistance: Double = 0
        if sorted.count > 1 {
            totalDistance = sorted.last!.odometer - sorted.first!.odometer
        }
        
        let avgEfficiency = totalFuel > 0 ? (totalDistance / totalFuel) : 0
        
        return (avgEfficiency, totalCost, totalDistance, totalFuel)
    }
}
