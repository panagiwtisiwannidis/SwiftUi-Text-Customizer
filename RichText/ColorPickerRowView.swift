
import SwiftUI

struct ColorPickerRow: View {
    let title: String
    let colors: [Color]
    let action: (Color) -> Void
    let dim: CGFloat = 28.0
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack(spacing: 12){
                ForEach(colors, id: \.self){ color in
                    Button {
                        action(color)
                    } label: {
                        Circle()
                            .fill(color)
                            .frame(width: dim, height: dim)
                            .overlay{
                                Circle()
                                    .stroke(Color.primary.opacity(0.2))
                            }
                    }

                }
            }
        }
    }
}

#Preview {
    ColorPickerRow(title: " ", colors: [.red,.orange,.blue], action: {_ in})
}
