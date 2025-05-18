//
//  RadioGroupCircleComponent.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import SwiftUI

struct RadioGroupCircleComponent: View {
    
    var isSelected: Bool
    
    var body: some View {
        
            Circle()
            .frame(width: 14, height: 14)
            .foregroundStyle(isSelected ? ColorEnum.secondColor.color : .white)
            .overlay {
                if(isSelected) {
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundStyle(.white)
                        .shadow(radius: 1)
                } else {
                    Circle()
                        .stroke(lineWidth: 1)
                        .foregroundStyle(ColorEnum.circleBorderColor.color)
                }
            }
            .padding(17)
            
                
        
    }
}

#Preview {
    VStack {
        RadioGroupCircleComponent(isSelected: true)
            .padding(.bottom)
        RadioGroupCircleComponent(isSelected: false)
    }
}
