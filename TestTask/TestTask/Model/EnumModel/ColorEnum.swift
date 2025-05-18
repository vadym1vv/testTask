//
//  ColorEnum.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

enum ColorEnum: String {
    case backgroundColor, primColor, secondColor, black60, customLightGray, black87, borderColor, schemesOnSurface, circleBorderColor, black48, error
    
    var color: Color {
        Color(rawValue)
    }
}
