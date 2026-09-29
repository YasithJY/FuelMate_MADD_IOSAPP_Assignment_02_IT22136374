import SwiftUI
import SwiftData

struct AddFuelView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var fuelAmount: String = ""
    @State private var totalPrice: String = ""
    @State private var odometer: String = ""
    @State private var stationName: String = ""
    @State private var date: Date = Date()
    @State private var notes: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Fuel Details")) {
                    TextField("Fuel Amount (Litres)", text: $fuelAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Total Price ($)", text: $totalPrice)
                        .keyboardType(.decimalPad)
                    
                    TextField("Odometer Reading (km)", text: $odometer)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Station & Date")) {
                    TextField("Station Name", text: $stationName)
                    
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section(header: Text("Additional Info")) {
                    TextField("Notes (Optional)", text: $notes)
                }
                
                Section {
                    PrimaryButton(title: "Save Record", icon: "checkmark") {
                        saveRecord()
                    }
                }
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("Add Fuel")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
    
    private func saveRecord() {
        guard let fuel = Double(fuelAmount),
              let price = Double(totalPrice),
              let odo = Double(odometer),
              !stationName.isEmpty else {
            // In a real app, show an alert here
            print("Validation failed")
            return
        }
        
        let newEntry = FuelEntry(
            fuelAmount: fuel,
            totalPrice: price,
            odometer: odo,
            stationName: stationName,
            notes: notes
        )
        
        modelContext.insert(newEntry)
        dismiss()
    }
}

#Preview {
    AddFuelView()
}
