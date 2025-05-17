
import Foundation

struct APIClient {
    private var baseURL: URL
    private var urlSession: URLSession
    private(set) var middlewares: [any APIClient.Middleware]
    
    init (baseUrl: URL, urlSession: URLSession = URLSession.shared, middlewares: [any APIClient.Middleware] = []) {
        self.baseURL = baseUrl
        self.urlSession = urlSession
        self.middlewares = middlewares
    }
    
    func sendRequest(_ apiSpec: APISpec) async throws -> DecodableType {
        guard let url = URL(string: baseURL.absoluteString + apiSpec.endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TimeInterval(floatLiteral: 30.0))
        request.httpMethod = apiSpec.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpBody = apiSpec.body
        
        for middleware in middlewares {
            let tempRequest = request
            request = try await wrapCatchingErrors {
                try await middleware.intercept(tempRequest)
            }
        }
        
        var responseData: Data? = nil
        
        do {
            let (data, response) = try await urlSession.data(for: request)
            try handleResponse(data: data, response: response)
            responseData = data
        } catch {
            throw error
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(apiSpec.returnType, from: responseData!)
            return decodedData
        } catch let error as DecodingError {
            throw error
        } catch {
            throw NetworkError.dataConversionFailure
        }
    }
    
    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard(200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
    
    func wrapCatchingErrors<R>(work: () async throws -> R) async throws -> R {
        do {
            return try await work()
        } catch {
            throw error
        }
    }
}

extension APIClient {
    protocol APISpec {
        var endpoint: String { get }
        var method: HttpMethod { get }
        var returnType: DecodableType.Type { get }
        var body: Data? { get }
    }
    
    protocol Middleware {
        func intercept(_ request: URLRequest) async throws -> (URLRequest)
    }
    
    enum HttpMethod: String, CaseIterable {
        case get = "GET"
    }
}

protocol DecodableType: Decodable { }

extension Array: DecodableType where Element: DecodableType {}
