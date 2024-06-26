import XCTest
@testable import GifSearch

final class GifSearchTests: XCTestCase {
    
    private var gifViewModel: GifViewModel!
    private var mockURLSession: MockURLSession!

    @MainActor override func setUpWithError() throws {
        continueAfterFailure = false
        gifViewModel = GifViewModel()
        mockURLSession = MockURLSession()
    }

    override func tearDownWithError() throws {
        gifViewModel = nil
        mockURLSession = nil
    }
    
    func testGetGifsSuccess() async throws {
        
        mockURLSession.data = jsonTestingData
        mockURLSession.urlResponse = HTTPURLResponse(url: URL(string: " ")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        let gifs = try await gifViewModel.getGifs(offset: 0, urlSession: mockURLSession)
        let gif: GifData = gifs[0]

        XCTAssertEqual(gif.title, "Schools Out Fun GIF by Pen Pals")
        XCTAssertEqual(gif.images.fixed_width.url, "https://media1.giphy.com/media/E6pqjeQ5JNj1lxhVOq/200w.gif?cid=93756d72z4pd3hjf8tf6y1n3rjkkweqlgju2t80bkbw72pws&ep=v1_gifs_trending&rid=200w.gif&ct=g")
        XCTAssertEqual(gif.images.fixed_width.height, "200")
    }
}
