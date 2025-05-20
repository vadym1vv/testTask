//
//  UserCard.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import SwiftUI

struct UserCardComponent: View {
    
    let urlUser: UrlUser
    let isLastUser: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                if let photo = urlUser.photo {
                    AsyncImage(url: URL(string: photo))
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)
                        .padding(.trailing, 16)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(urlUser.name ?? "")
                        .multilineTextAlignment(.leading)
                        .font(FontEnum.nutino18.font)
                        .padding(.bottom, 4)
                    Text(urlUser.position ?? "")
                        .foregroundStyle(ColorEnum.black60.color)
                        .padding(.bottom, 8)
                    Text(urlUser.email ?? "")
                        .lineLimit(1)
                    Text(urlUser.phone ?? "")
                        .padding(.bottom, 24)
                    if(!isLastUser) {
                        Rectangle()
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .foregroundStyle(ColorEnum.borderColor.color)
                    }
                }
                .foregroundStyle(ColorEnum.black87.color)
                .font(FontEnum.nutino14.font)
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            
        }
    }
}

#Preview {
    UserCardComponent(urlUser: UrlUser(id: 4, name: "user name asfasf asfasf asfasfas fasf asf as", email: "user@gmail.com asf asf asf asf asf asf asf asf asf asf asf asf asf ", phone: "+380233634623", position: "user position", positionID: 1, registrationTimestamp: 32526, photo: "https://frontend-test-assignment-api.abz.agency/images/users/5b977ba1245cc29.jpeg"), isLastUser: false)
}
