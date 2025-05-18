//
//  TextInputStatusEnum.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import SwiftUI

enum TextInputStatusEnum {
    case  error,  none
    
//    var background: Color {
//        switch self {
//        case .focused, .none, .error:
//            Color(ColorEnum.layerDarkMod200.color)
//        case .empty:
//            Color(ColorEnum.layer400.color)
//        }
//    }
    
    var strokeColor: Color {
        switch self {
//        case .focused:
//            Color(ColorEnum.accent100.color)
        case .error:
            ColorEnum.error.color
        case  .none:
            ColorEnum.black48.color
        }
    }
}
