//
//  SkillsViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation
import FirebaseStorage
import Combine

enum DataFetchError: Error {
    case downloadError(String)
    case decodeError(String)
    case unknownError(String)
}

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
         } catch let error as NSError {
             // Aqui você pode tratar diferentes tipos de erros e lançar um erro personalizado
             if error.domain == StorageErrorDomain {
                 throw DataFetchError.downloadError("Erro ao baixar os dados: \(error.localizedDescription)")
             } else if error.domain == NSCocoaErrorDomain {
                 throw DataFetchError.decodeError("Erro ao decodificar os dados: \(error.localizedDescription)")
             } else {
                 throw DataFetchError.unknownError("Erro desconhecido: \(error.localizedDescription)")
             }
         }
     }
 }
