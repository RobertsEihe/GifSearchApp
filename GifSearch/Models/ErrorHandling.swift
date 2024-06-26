import Foundation

enum HandleError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

extension Error {
    
    func handleError(alertMessage: inout String, showAlert: inout Bool){
        if let ghError = self as? HandleError {
            switch ghError {
            case .invalidURL:
                alertMessage = "Invalid URL"
            case .invalidResponse:
                alertMessage = "Invalid Response"
            case .invalidData:
                alertMessage = "Invalid Data"
            }
        } else {
            alertMessage = "Unexpected error: \(self.localizedDescription)"
        }
        showAlert = true
    }
}
