import SwiftUI

struct PrimaryButton: View {
    var title: String
    var icon: String? = nil
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                }
                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.black)
            .cornerRadius(12)
            .shadow(color: Color.green.opacity(0.3), radius: 5, x: 0, y: 3)
        }
    }
}

#Preview {
    PrimaryButton(title: "Save Record", icon: "checkmark", action: {})
        .padding()
}
