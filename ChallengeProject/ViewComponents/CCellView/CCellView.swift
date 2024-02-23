//
//  CCellView.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 22/02/2024.
//

import Foundation
import SwiftUI

struct CCellView: View {
    
    @State var isExpanded: Bool = false
    @State var rotationAngle: Double = 0
    
    var name: String
    var addresses: String
    var rowHeight: CGFloat
    
    var body: some View {
        HStack(alignment:.center) {
            Text(name.prefix(1))
            VStack {
                DisclosureGroup(
                    isExpanded: $isExpanded,
                    content: {
                        HStack {
                            Text(addresses)
                            Spacer()
                        }
                    },
                    label: {
                        Text(name)
                    }
                )
            }
            Button(action: {
                isExpanded.toggle()
            }) {
                Image(systemName: "chevron.right")
                    .rotationEffect(Angle(degrees: rotationAngle))
                    .animation(.easeInOut, value: rotationAngle)
                    .foregroundColor(CColors.gray1)
                    .padding(.trailing, 6)
            }
        }
        .frame(height: rowHeight)
        .listRowBackground(Color.white)
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 18))
        .foregroundColor(.black)
        .buttonStyle(PlainButtonStyle()).accentColor(.clear).disabled(true)
        .onChange(of: isExpanded) {
            if isExpanded {
                rotationAngle = 90
            } else {
                rotationAngle = 0
            }
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
