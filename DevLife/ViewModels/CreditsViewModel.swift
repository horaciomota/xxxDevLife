//
//  CreditsViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 07/11/23.
//

import Foundation

class CreditsViewModel: ObservableObject {
    @Published var credits: Int = 6 // Créditos iniciais

    func useCredits(for skill: SkillItem) {
        if credits >= skill.cost {
            credits -= skill.cost
        } else {
            // Lógica para quando não há créditos suficientes
            print("Not enough credits")
        }
    }
}

