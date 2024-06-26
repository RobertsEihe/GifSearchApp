import Foundation

@MainActor
class GifViewModel: ObservableObject {
    
    @Published var gifs: [GifData] = []
    @Published var detailGifSheet: GifSheetDetails?
    @Published var offset: Int = 0
    @Published var isLoading: Bool = false
    @Published var isSearchGifUsed: Bool = true
    @Published var searchText: String = ""
    @Published var isActiveSearchBar = true
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    
    let apiKey = "hRkoDriDnlklR6dqQHyscRDR3OcP5FLS"
    let limit = 25
    
    func searchGifs() async {
        guard !isLoading else { return }
        isLoading = true
        offset = 0
        gifs.removeAll()
        isSearchGifUsed = true
        
        if searchText != "" {
            do {
                gifs = try await getGifs(offset: offset)
            } catch {
                error.handleError(alertMessage: &alertMessage, showAlert: &showAlert)
            }
        }
        isLoading = false
    }
    
    func loadMoreGifs() {
        guard !isLoading else { return }
        isLoading = true
        
        Task {
            do {
                let moreGifs = try await getGifs(offset: offset + limit)
                gifs.append(contentsOf: moreGifs)
                offset += limit
            } catch {
                error.handleError(alertMessage: &alertMessage, showAlert: &showAlert)
            }
        }
        isLoading = false
    }
    
    func getGifs(offset: Int, urlSession: URLSessionProtocol = URLSession.shared) async throws -> [GifData] {
        var endpoint = ""
        if isSearchGifUsed {
            endpoint = "https://api.giphy.com/v1/gifs/search?api_key=\(apiKey)&q=\(searchText)&limit=\(limit)&offset=\(offset)&rating=g"
        } else {
            endpoint = "https://api.giphy.com/v1/gifs/trending?api_key=\(apiKey)&limit=\(limit)&offset=\(offset)&rating=g"
        }
        
        guard let url = URL(string: endpoint) else { throw HandleError.invalidURL }
        let (data, response) = try await urlSession.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw HandleError.invalidResponse }
        do {
            let decoder = JSONDecoder()
            let giphyResponse = try decoder.decode(GiphyResponse.self, from: data)
            return giphyResponse.data
        } catch {
            throw HandleError.invalidData
        }
    }
}
