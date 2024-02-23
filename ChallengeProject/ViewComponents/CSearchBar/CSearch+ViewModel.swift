//
//  CSearch+ViewModel.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import Observation
import SwiftUI

extension CSearchBar {
    @Observable
    class ViewModel {
        var isEditing = false
        private let animationDuration: Double = 0.25
        
        
        func startEditing(_ editing: Bool) {
            withAnimation(.easeInOut(duration: animationDuration)) {
                self.isEditing = editing
            }
        }
    }
}
