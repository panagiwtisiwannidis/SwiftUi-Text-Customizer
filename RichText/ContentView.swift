
import SwiftUI

@available(macOS 26.0, *)
struct ContentView: View {
    @State private var text = AttributedString()
    @State private var selection = AttributedTextSelection()
    @Environment(\.fontResolutionContext) var fontResolutionContext
    let foregroundColors: [Color] = [.black,.red,.blue,.green,.purple]
    let backgroundColors: [Color] = [.white,.gray.opacity(0.2),.yellow.opacity(0.3),.mint.opacity(0.3),.cyan.opacity(0.3),.orange.opacity(0.3)]
    
    var body: some View {
        VStack {
            //Text Editor
            TextEditor(text: $text, selection: $selection)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.secondary.opacity(0.3))
                }
            VStack(spacing: 16){
                //Underline, Strikethrough, Baseline
                HStack{
                    Button("", systemImage: "underline") {
                        text.transformAttributes(in: &selection){container in
                            let current = container
                                .underlineStyle
                            container
                                .underlineStyle = current == .single ? nil: .single
                        }
                    }
                    Button("", systemImage: "strikethrough") {
                        text.transformAttributes(in: &selection){container in
                            let current = container
                                .strikethroughStyle
                            container
                                .strikethroughStyle = current == .single ? nil: .single
                        }
                    }
                    Button("", systemImage: "arrow.up") {
                        text.transformAttributes(in: &selection){container in
                            let baseLine = container.baselineOffset
                            
                            container
                                .baselineOffset = (baseLine ?? 0) + 2
                        }
                    }
                    Button("", systemImage: "arrow.down") {
                        text.transformAttributes(in: &selection){container in
                            let baseLine = container.baselineOffset
                            
                            container
                                .baselineOffset = (baseLine ?? 0) - 2
                        }
                    }
                }
                .buttonStyle(.glassProminent)
                // Foreground and Background Colors
                HStack {
                    VStack(alignment: .leading){
                        ColorPickerRow(title: "Text Color", colors: foregroundColors) { color in
                            text
                                .transformAttributes(in: &selection) { container in
                                    container.foregroundColor = color
                                }
                        }
                        ColorPickerRow(title: "Background Color", colors: backgroundColors) { color in
                            text
                                .transformAttributes(in: &selection) { container in
                                    container.backgroundColor = color
                                }
                        }
                    }
                    Spacer()
                    // Bold and Italic
                    VStack(alignment: .leading){
                        Button("Bold", systemImage: "bold"){
                            text
                                .transformAttributes(in: &selection) { container in
                                    let current = container.font ?? .default
                                    let resolved = current
                                        .resolve(in: fontResolutionContext)
                                    let isBold = resolved.isBold
                                    container
                                        .font = current.bold(!isBold)
                                }
                        }
                        Button("Italic", systemImage: "italic"){
                            text
                                .transformAttributes(in: &selection) { container in
                                    let current = container.font ?? .default
                                    let resolved = current
                                        .resolve(in: fontResolutionContext)
                                    let isItalic = resolved.isItalic
                                    container
                                        .font = current.italic(!isItalic)
                                }
                        }
                    }
                }
                // Alignment
                HStack{
                    Button("", systemImage: "text.alignleft") {
                        text.transformAttributes(in: &selection){container in
                            container
                                .alignment = .left
                            
                        }
                    }
                    Button("", systemImage: "text.aligncenter") {
                        text.transformAttributes(in: &selection){container in
                            container
                                .alignment = .center
                            
                        }
                    }
                    Button("", systemImage: "text.alignright") {
                        text.transformAttributes(in: &selection){container in
                            container
                                .alignment = .right
                            
                        }
                    }
                }
                // Fonts
                HStack{
                    let fonts: [Font] = [.largeTitle,.title,.body,.headline,.subheadline,.caption]
                    ForEach(fonts, id: \.self) { font in
                        Button("Aa") {
                            text.transformAttributes(in: &selection){container in
                                container
                                    .font = font
                                
                            }
                        }
                        .font(font)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    if #available(macOS 26.0, *) {
        ContentView()
    } else {
        // Fallback on earlier versions
    }
}
