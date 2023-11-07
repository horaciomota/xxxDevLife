//
//  AppViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 07/11/23.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var isCharacterCreated: Bool

    init() {
        // Verifica se o personagem já foi criado
        self.isCharacterCreated = UserDefaults.standard.bool(forKey: "isCharacterCreated")
    }

    func createCharacter() {
        // Cria o personagem e salva a flag no UserDefaults
        UserDefaults.standard.set(true, forKey: "isCharacterCreated")
        self.isCharacterCreated = true
    }
}

