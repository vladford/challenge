//
//  CCell+ViewBuilder.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import SwiftUI

extension CCellView {
    
    @ViewBuilder
    func chevronButton() -> some View {
        Button(action: {
            viewModel.isExpanded.toggle()
        }) {
            Image(systemName: "chevron.right")
                .resizable()
                .rotationEffect(Angle(degrees: viewModel.rotationAngle))
                .animation(.easeInOut, value: viewModel.rotationAngle)
                .frame(width: chevronSize.width, height: chevronSize.height)
                .tint(CColors.gray1)
                .padding(.trailing, chevronTrailingPadding)
        }
    }
    
    @ViewBuilder
    func circleIcon(letter: String, diameter: CGFloat, color: Color, outlineColor: Color, letterColor: Color, letterSize: CGFloat) -> some View {
        ZStack {
            Circle()
                .fill(color)
                .stroke(outlineColor, lineWidth: 0.5)
                .frame(width: diameter, height: diameter)
            
            Text(letter)
                .font(.system(size: letterSize))
                .foregroundColor(letterColor)
        }
    }
}
