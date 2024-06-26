import Foundation

struct GiphyResponse: Decodable {
    let data: [GifData]
}

struct GifData: Decodable {
    let images: ImageData
    let title: String
}

struct ImageData: Decodable {
    let fixed_width: OriginalImageData
}

struct OriginalImageData: Decodable {
    let url: String
    let height: String
}
