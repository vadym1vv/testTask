
import Foundation
// "API pattern based on: https://calincrist.com/the-perfect-ios-networking-layer-does-not-exists---part-1
struct APIClient {
    private var baseURL: URL
    private var urlSession: URLSession
    private(set) var middlewares: [any APIClient.Middleware]
    
    init (baseUrl: URL, urlSession: URLSession = URLSession.shared, middlewares: [any APIClient.Middleware] = []) {
        self.baseURL = baseUrl
        self.urlSession = urlSession
        self.middlewares = middlewares
    }
    
    func sendRequest(_ apiSpec: APISpec, token: String? = nil) async throws -> DecodableType {
        guard let url = URL(string: baseURL.absoluteString + apiSpec.endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: TimeInterval(floatLiteral: 30.0))
        request.httpMethod = apiSpec.method.rawValue
        
        //multipart post condition settings
        if apiSpec.isMultipart, let registrationRequest = apiSpec as? UserUrlRequestEnum {
            let boundary = registrationRequest.multipartBoundary ?? "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            if case let .registrationRequest(model) = registrationRequest {
                request.httpBody = createMultipartBody(model: model, boundary: boundary)
            }
            if let token {
                request.setValue(token, forHTTPHeaderField: "token")
            }
        } else {
            request.httpBody = apiSpec.body
        }
        
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
    
    //custom error handler
    private func handleResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            if (httpResponse.statusCode == 422 || httpResponse.statusCode == 409) {
                do {
                    let errorResponse = try JSONDecoder().decode(ValidationErrorResponse.self, from: data)
                    throw errorResponse
                }
            }  else {
                throw NetworkError.requestFailed(statusCode: httpResponse.statusCode)
            }
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
        var isMultipart: Bool { get }
        var multipartBoundary: String? { get }
        var body: Data? { get }
    }
    
    protocol Middleware {
        func intercept(_ request: URLRequest) async throws -> (URLRequest)
    }
    
    enum HttpMethod: String, CaseIterable {
        case get = "GET", post = "POST"
    }
}

protocol DecodableType: Decodable { }

extension Array: DecodableType where Element: DecodableType {}
