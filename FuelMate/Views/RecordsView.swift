import SwiftUI
import SwiftData

struct RecordsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FuelEntry.date, order: .reverse) private var entries: [FuelEntry]
    @State private var searchText = ""
    
    var filteredEntries: [FuelEntry] {
        if searchText.isEmpty {
            return entries
        } else {
            return entries.filter { $0.stationName.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                if entries.isEmpty {
                    VStack {
                        Image(systemName: "list.clipboard")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                            .padding()
                        Text("No Fuel Records")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        Text("Your fuel entries will appear here.")
                            .foregroundColor(.gray)
                    }
                } else {
                    List {
                        ForEach(filteredEntries) { entry in
                            NavigationLink(destination: FuelDetailView(entry: entry)) {
                                FuelRecordRow(entry: entry)
                            }
                            .listRowBackground(Color(UIColor.secondarySystemBackground).opacity(0.3))
                        }
                        .onDelete(perform: deleteRecords)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Fuel Records")
            .searchable(text: $searchText, prompt: "Search stations")
        }
    }
    
    private func deleteRecords(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(filteredEntries[index])
            }
        }
    }
}

#Preview {
    RecordsView()
}
