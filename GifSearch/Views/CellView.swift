import SwiftUI

struct CellView: View {
    
    @StateObject var viewModel: GifViewModel
    let gif: GifData
        
    var body: some View {
        WebView(gifURL: URL(string: gif.images.fixed_width.url)!)
            .aspectRatio(contentMode: .fill)
            .frame(height: 175)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onTapGesture {
                viewModel.detailGifSheet = GifSheetDetails(id: gif.images.fixed_width.url, title: gif.title, height: gif.images.fixed_width.height)
                viewModel.isActiveSearchBar = false
            }
    }
}
