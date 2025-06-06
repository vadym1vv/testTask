//
//  ColorEnum.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import Foundation

//responsible for all icons
enum IconEnum: String {
    case emailIsAlreadyRegistered, noInternetConnection, noUsers, userRegistered, logo, signUp, users
    
    var icon: String {
        self.rawValue
    }
}
