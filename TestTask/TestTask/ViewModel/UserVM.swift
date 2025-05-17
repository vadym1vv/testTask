//
//  UserVM.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import Foundation

@MainActor
class UserVM: ParentApiRequestVM <UserUrlRequestApiService> {
    
    @Published var users: [UrlUser] = []
    @Published var currentPage: Int = 0
    @Published var isLastPage: Bool = false
    @Published private(set) var currentNetworkCallState: CurrentLoadingState?
    
    func getUsers() async {
        print("getUsersPerformed")
        defer {currentNetworkCallState = .finished}
        currentNetworkCallState = .loading
        
        let getUsersUrlRequestModel: GetUserModel? = await apiService.fetchUsersList(page: currentPage + 1)
        if let usersUrlRequestModel = getUsersUrlRequestModel, let totlaPages = usersUrlRequestModel.totalPages, var users = usersUrlRequestModel.users, let page = usersUrlRequestModel.page  {
            print("Current pate\(currentPage)")
            print("total pate\(totlaPages)")
            if (totlaPages <= (currentPage + 1)) {
                isLastPage = true
            }
            currentPage = page
            users.sort(by: {$0.registrationTimestamp ?? Int.min > $1.registrationTimestamp ?? Int.min})
            self.users.append(contentsOf: users)
        }
    }
}
