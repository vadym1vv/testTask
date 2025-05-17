
import Foundation

class APIService {
    private(set) var apiClient: APIClient?
    required init(apiClient: APIClient? = nil) {
        self.apiClient = apiClient
    }
}
