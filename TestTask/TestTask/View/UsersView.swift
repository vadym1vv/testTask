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
