//
//  CCell+ViewModel.swift
//  ChallengeProject
//
//  Created by Wladyslaw Jasinski on 23/02/2024.
//

import Foundation
import Observation

extension CCellView {
   
    @Observable
    class ViewModel {
        var isExpanded: Bool = false
        var rotationAngle: Double = 0
        
        func updateChevronRotation() {
            if isExpanded {
                rotationAngle = 90
            } else {
                rotationAngle = 0
            }
        }
    }
}
