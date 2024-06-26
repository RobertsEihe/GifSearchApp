import SwiftUI

struct GifSheetDetails: Identifiable {
    var id: String
    let title: String
    let height: String
}

struct DetailedGifSheetView: View {
    
    @Environment(\.dismiss) private var dismiss
    let detail: GifSheetDetails
    var intHeight: Double? { Double(detail.height)}
    
    var body: some View {
        NavigationStack {
            VStack {
                WebView(gifURL: URL(string: detail.id)!)
                    .frame(maxHeight: (intHeight ?? 200)*1.55)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .aspectRatio(contentMode: .fit)
                    .padding(32)
                Text("GIF title:")
                    .padding(.horizontal, 32)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(detail.title)
                    .padding(.horizontal, 32)
                    .font(.system(size: 20))
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Done"){
                        dismiss()
                    }
                    .buttonStyle(.borderless)
                    .font(.headline)
                }
            }
            .padding(8)
        }
    }
}
