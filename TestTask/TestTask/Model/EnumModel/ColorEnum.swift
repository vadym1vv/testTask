//
//  ColorEnum.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

enum ColorEnum: String {
    case backgroundColor, primColor, secondColor, unselectedColor, lightGray
    
    var color: Color {
        Color(rawValue)
    }
}
