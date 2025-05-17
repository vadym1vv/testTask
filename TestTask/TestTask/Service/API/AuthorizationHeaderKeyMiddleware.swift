
import Foundation

class AuthorizationHeaderKeyMiddleware: APIClient.Middleware {
    
    var key: String
    var httpHeaderName: String
    
    init(key: String, httpHeaderName: String) {
        self.key = key
        self.httpHeaderName = httpHeaderName
    }
    
    func intercept(_ request: URLRequest) async throws -> (URLRequest) {
        var requestCopy = request
        requestCopy.addValue(key, forHTTPHeaderField: httpHeaderName)
        return requestCopy
    }
}
