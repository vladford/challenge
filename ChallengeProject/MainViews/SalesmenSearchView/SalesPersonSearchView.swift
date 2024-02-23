//
//  SalesPersonSearchView.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 21/02/2024.
//

import SwiftUI

struct SalesPersonSearchView: View {
    
    let data: [SalesPerson] = [
        SalesPerson(name:"Artem Titarenko", areas: ["76133"]),
        SalesPerson(name:"Bernd Schmitt", areas: ["7619*"]),
        SalesPerson(name:"Chris Krapp", areas: ["762*"]),
        SalesPerson(name:"Alex Uber", areas: ["86*"])
    ]
    
    @State var searchText = ""
    
    private let rowHeight: CGFloat = 68
    private let serachBarHeight: CGFloat = 44
    private let serachTopPadding: CGFloat = 17
    private let serachSidePadding: CGFloat = 16
    
    var body: some View {
        NavigationView {
            VStack {
                CSearchBar(text: $searchText)
                    .frame(height: serachBarHeight)
                    .padding(.top, serachTopPadding)
                    .padding([.leading, .trailing], serachSidePadding)
                List {
                    ForEach(data) { person in
                        CCellView(name: person.name, addresses: "some areas", rowHeight: rowHeight)
                            .listSectionSeparator(.hidden, edges: .top)
                            .listRowSeparatorTint(CColors.gray3)
                    }
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .padding(.leading)
                
            }
            .background(CColors.background)
            .navigationBarTitle(CStrings.adresses, displayMode: .inline)
            .toolbarBackground(CColors.header, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    SalesPersonSearchView()
}
