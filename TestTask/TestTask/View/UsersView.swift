//
//  UsersView.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

struct UsersView: View {
    
    @EnvironmentObject private var userVM: UserVM
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(userVM.users, id: \.self) { user in
                        UserCardComponent(urlUser: user, isLastUser: userVM.users.last == user)
                    }
                    VStack {
                        if (!userVM.isLastPage) {
                            ProgressView()
                        }
                    }
                    .frame(height: 10)
                    .frame(maxWidth: .infinity)
                    .onAppear {
                        Task {
                            await userVM.getUsers()
                            // Because there is a limit of 6 users per request, the VStack does not disappear and the next request is not triggered. This issue occurs only on iPad due to its screen size; on iPhone, it works correctly. additional getUsers() call fix this problem. ONLY FOR IPAD
                            if (UIDevice.current.userInterfaceIdiom == .pad && userVM.users.count < 12) {
                                await userVM.getUsers()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    UsersView()
        .environmentObject(UserVM())
}
