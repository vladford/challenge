//
//  CSearchBar.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 22/02/2024.
//

import Foundation
import SwiftUI

struct CSearchBar: View {
    @Binding var text: String
    @FocusState var isTextFieldFocused: Bool
    @State var viewModel = ViewModel()
    
     let height: CGFloat = 36
     let horizontalPadding: CGFloat = 30
     let cornerRadius: CGFloat = 10
     let leftSideIconPadding: CGFloat = 8
     let rightSideIconPadding: CGFloat = 10
     let cancelButtonPading: CGFloat = 10
    
    var body: some View {
        HStack {
            TextField(CStrings.search, text: $text)
                .focused($isTextFieldFocused)
                .frame(height: height)
                .padding(.horizontal, horizontalPadding)
                .background(CColors.backgroundAccent)
                .foregroundColor(CColors.gray2)
                .tint(CColors.gray2)
                .cornerRadius(cornerRadius)
                .overlay(
                    HStack {
                        lookingGlassIcon()
                        if viewModel.isEditing, !text.isEmpty {
                            xButton()
                        } else if !viewModel.isEditing, text.isEmpty{
                            micButton()
                        } else {
                            EmptyView()
                        }
                    }
                )
                .onTapGesture {
                    viewModel.startEditing(true)
                    isTextFieldFocused = true
                }
            
            if viewModel.isEditing {
                Button(action: {
                    viewModel.startEditing(false)
                    self.text = ""
                    isTextFieldFocused = false
                    
                }) {
                    Text(CStrings.cancel)
                        .foregroundColor(CColors.gray2)
                }
                .padding(.trailing, cancelButtonPading)
            }
        }
    }
}

