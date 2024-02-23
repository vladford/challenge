//
//  CSearchBar+Coordinator.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 22/02/2024.
//

import Foundation
import UIKit
import SwiftUI

extension CSearchBar {
    @ViewBuilder
    func lookingGlassIcon() -> some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(CColors.gray2)
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .padding(.leading, leftSideIconPadding)
    }
    
    @ViewBuilder
    func xButton() -> some View {
        Button(action: {
            self.text = ""
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(CColors.gray2)
                .padding(.trailing, rightSideIconPadding)
        }
    }
    
    @ViewBuilder
    func micButton() -> some View {
        Button(action: {
            viewModel.startEditing(true)
            isTextFieldFocused = true
            self.text = ""
        }) {
            Image(systemName: "mic.fill")
                .foregroundColor(CColors.gray2)
                .padding(.trailing, rightSideIconPadding)
        }
    }
}
