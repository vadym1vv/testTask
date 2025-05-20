//
//  FontEnum.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 16.05.2025.
//

import SwiftUI

//responsible for Nunito Sans size picker
enum FontEnum: CaseIterable {
    
    case nutino20, nutino16, nutino18, nutino14
    
    var font: Font {
        switch self {
        case .nutino20:
            return Font.custom("Nunito Sans", fixedSize: 20)
        case .nutino16:
            return Font.custom("Nunito Sans", fixedSize: 16)
        case .nutino18:
            return Font.custom("Nunito Sans", fixedSize: 18)
        case .nutino14:
            return Font.custom("Nunito Sans", fixedSize: 14)
        }
    }
}

struct FontEnum_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScrollView {
                ForEach(FontEnum.allCases, id: \.self) { font in
                    Text("Hello world")
                        .font(font.font)
                }
            }
        }
    }
}

