import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = GifViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 170, maximum: 250), spacing: 8)]) {
                ForEach(viewModel.gifs.indices, id: \.self) { index in
                    CellView(viewModel: viewModel, gif: viewModel.gifs[index])
                        .onAppear {
                            if index == viewModel.gifs.count - 1 && !viewModel.isLoading {
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
        .navigationTitle("Search GIFs")
        .searchable(text: $viewModel.searchText, isPresented: $viewModel.isActiveSearchBar, prompt: "Search GIFs")
        .onChange(of: viewModel.searchText) {
            Task {
                viewModel.isSearchGifUsed = true
                try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
                await viewModel.searchGifs()
            }
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
