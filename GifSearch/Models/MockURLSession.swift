import Foundation

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        guard let data = data, let urlResponse = urlResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, urlResponse)
    }
}
