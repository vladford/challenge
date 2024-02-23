//
//  SalesPersonSearchView.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 21/02/2024.
//

import SwiftUI

struct SalesPersonSearchView: View {
    
    @StateObject var viewModel = ViewModel(scheduler: DispatchQueue.main, networkService: NetworkService())
    
    private let rowHeight: CGFloat = 68
    private let serachBarHeight: CGFloat = 44
    private let serachTopPadding: CGFloat = 17
    private let serachSidePadding: CGFloat = 16
    
    var body: some View {
        NavigationView {
            VStack {
                CSearchBar(text: $viewModel.searchText, keyboardType: .phonePad, maxCharacters: 5)
                    .frame(height: serachBarHeight)
                    .padding(.top, serachTopPadding)
                    .padding([.leading, .trailing], serachSidePadding)
                List {
                    ForEach(viewModel.filteredData, id: \.self) { person in
                        CCellView(name: person.name, addresses: person.areasString, rowHeight: rowHeight)
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
        }.onAppear() {
            viewModel.loadData()
        }
    }
}

#Preview {
    SalesPersonSearchView()
}
