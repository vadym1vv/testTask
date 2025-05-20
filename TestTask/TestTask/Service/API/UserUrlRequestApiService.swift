//
//  UserUrlRequestApiService.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation

class UserUrlRequestApiService: APIService {
    
    func fetchUsersList(page: Int, count: Int) async -> GetUserModel? {
        let apiSpec: UserUrlRequestEnum = .userByPage(page: page, count: count)
        do {
            let usersUrlRequestModel = try await apiClient?.sendRequest(apiSpec)
            return usersUrlRequestModel as? GetUserModel
        } catch {
#if DEBUG
            print("\(error)")
            return nil
#else
            return nil
#endif
        }
    }
    
    func fetchPositionsList() async -> PositionsModel? {
        let apiSpec: UserUrlRequestEnum = .positions
        do {
            let positionsUrlRequestModel = try await apiClient?.sendRequest(apiSpec)
            return positionsUrlRequestModel as? PositionsModel
        } catch {
#if DEBUG
            print("\(error)")
            return nil
#else
            return nil
#endif
        }
    }
    
    //The thrown error is propagated to the UserVM
    func registrationRequest(registrationRequestModel: RegistrationRequestModel, token: String?) async throws -> SuccessRegistrationModel? {
        let apiSpec: UserUrlRequestEnum = .registrationRequest(registrationRequestModel: registrationRequestModel)
        let successRegistrationMessage = try await apiClient?.sendRequest(apiSpec, token: token)
        return successRegistrationMessage as? SuccessRegistrationModel
    }
    
    func fetchNewToken() async -> TokenModel? {
        let apiSpec: UserUrlRequestEnum = .token
        do {
            let newToken = try await apiClient?.sendRequest(apiSpec)
            return newToken as? TokenModel
        } catch {
#if DEBUG
            print("\(error)")
            return nil
#else
            return nil
#endif
        }
    }
}
