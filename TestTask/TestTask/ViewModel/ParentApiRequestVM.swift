//
//  ParentApiRequestVM.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation

class ParentApiRequestVM<T: APIService>: ObservableObject {
    let apiBaseUrl: URL
    let apiClient: APIClient
    let apiService: T
    let apiAuthorizationKeyMiddleware: APIClient.Middleware
    
    required init() {
        self.apiBaseUrl = URL(string: GlobalConstant.baseUrl)!
        self.apiAuthorizationKeyMiddleware = AuthorizationHeaderKeyMiddleware(key: "application/json", httpHeaderName: "accept")
        self.apiClient = APIClient(baseUrl: apiBaseUrl, middlewares: [apiAuthorizationKeyMiddleware])
        self.apiService = T(apiClient: apiClient)
    }
}
