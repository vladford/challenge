//
//  CCellView.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 22/02/2024.
//

import Foundation
import SwiftUI

struct CCellView: View {
    
    @State var viewModel = ViewModel()
    
    var name: String
    var addresses: String
    var rowHeight: CGFloat
    
    let iconDiameter: CGFloat = 42
    let iconFontSize: CGFloat = 20
    let detailFontSize: CGFloat = 15
    let labelFontize: CGFloat = 17
    let lineRowTrailingInset: CGFloat = 17
    let chevronSize: CGSize = CGSize(width: 8, height: 13)
    let chevronTrailingPadding: CGFloat = 6
    
    var body: some View {
        HStack(alignment:.center) {
            circleIcon(
                letter: String(name.prefix(1)),
                diameter: iconDiameter,
                color: CColors.backgroundAccent,
                outlineColor: CColors.gray4,
                letterColor: CColors.mainText,
                letterSize: iconFontSize)
            .padding([.leading, .trailing], 1)
            VStack {
                DisclosureGroup(
                    isExpanded: $viewModel.isExpanded,
                    content: {
                        HStack {
                            Text(addresses)
                                .font(.system(size: detailFontSize))
                                .foregroundColor(CColors.gray1)
                            Spacer()
                        }
                    },
                    label: {
                        Text(name)
                        .font(.system(size: labelFontize))
                    }
                )
            }
            chevronButton()
                
        }
        .frame(height: rowHeight)
        .listRowBackground(Color.clear)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: lineRowTrailingInset))
        .foregroundColor(CColors.mainText)
        .buttonStyle(PlainButtonStyle()).accentColor(.clear).disabled(true)
        .onChange(of: viewModel.isExpanded) {
            viewModel.updateChevronRotation()
        }
    }
}

#Preview {
    List {
        CCellView(name: "XXX", addresses: "yyyy", rowHeight: 64)
        CCellView(name: "XXX", addresses: "yyyy", rowHeight: 64)
    }
    .background(Color.white)
    .scrollContentBackground(.hidden)
    .ignoresSafeArea()
    .offset(x: 15)
}
