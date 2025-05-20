//
//  PositionComponent.swift
//  TestTask
//
//  Created by Vadym Vasylaki on 17.05.2025.
//

import SwiftUI

struct PositionComponent: View {
    
    @Binding var selectedPosition: Position?
    
    let positions: [Position]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select your position")
                .font(FontEnum.nutino18.font)
            ForEach(positions, id: \.self) { position in
                if let name = position.name {
                    Button {
                        withAnimation {
                            selectedPosition = position
                        }
                    } label: {
                        HStack(spacing: 8) {
                            RadioGroupCircleComponent(isSelected: position == selectedPosition)
                            Text(name)
                                .font(FontEnum.nutino16.font)
                        }
                    }
                }
            }
        }
        .foregroundStyle(ColorEnum.black87.color)
    }
}

#Preview {
    PositionComponent(selectedPosition: .constant(Position(id: 1, name: "FrontEnt developer")), positions: [Position(id: 3, name: "FrontEnt developer")])
}



