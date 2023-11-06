//
//  SkillsViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation
import FirebaseStorage
import Combine

class SkillsViewModel: ObservableObject {
    @Published var skillsData: SkillsData?

    // Função assíncrona para buscar os dados do JSON
    func fetchSkillsJson() async throws {
        let storage = Storage.storage()
        let skillsRef = storage.reference().child("SkillsEvents.json")

        do {
            let data = try await skillsRef.data(maxSize: 1 * 1024 * 1024)

            // Decodificar o JSON em objetos SkillsData
            let decoder = JSONDecoder()
            let skillsData = try decoder.decode(SkillsData.self, from: data)

            // Atualizar a UI no thread principal
            await MainActor.run {
                self.skillsData = skillsData
            }
        } catch {
            throw error
        }
    }
}
