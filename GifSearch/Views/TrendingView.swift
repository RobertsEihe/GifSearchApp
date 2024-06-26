import SwiftUI

struct TrendingView: View {
    
    @StateObject private var viewModel = GifViewModel()
    
    var body: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 170, maximum: 250), spacing: 8)], spacing: 8) {
                ForEach(viewModel.gifs.indices, id: \.self) { index in
                    CellView(viewModel: viewModel, gif: viewModel.gifs[index])
                        .onAppear {
                            if index == viewModel.gifs.count - 1 {
                                viewModel.loadMoreGifs()
                            }
                        }
                }
            }
            .padding(8)
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
        }
        .navigationTitle("Trending GIFs")
        .task {
            viewModel.isLoading = true
            do {
                viewModel.isSearchGifUsed = false
                viewModel.gifs = try await viewModel.getGifs(offset: viewModel.offset)
            }
            catch {
                error.handleError(alertMessage: &viewModel.alertMessage, showAlert: &viewModel.showAlert)
            }
            viewModel.isLoading = false
        }
        .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
        .sheet(item: $viewModel.detailGifSheet) { detail in
            DetailedGifSheetView(detail: detail)
        }
    }
}
