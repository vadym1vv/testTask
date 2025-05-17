//
//  UserUrlRequestApiService.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation

class UserUrlRequestApiService: APIService {
    
    func fetchUsersList(page: Int) async -> GetUserModel? {
        let apiSpec: UserUrlRequestEnum = .userByPage(page: page, count: 6)
        do {
            let usersUrlRequestModel = try await apiClient?.sendRequest(apiSpec)
            return usersUrlRequestModel as? GetUserModel
        } catch {
            return nil
        }
    }
}
