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
    @Published var errorMessage: String?

    func fetchSkillsJson() async {
        let storage = Storage.storage()
        let skillsRef = storage.reference().child("SkillsEvents.json")

        do {
            let data = try await skillsRef.data(maxSize: 1 * 1024 * 1024)
            let decoder = JSONDecoder()
            self.skillsData = try decoder.decode(SkillsData.self, from: data)
        } catch let error as NSError {
            self.errorMessage = "Error: \(error.domain), \(error.code), \(error.localizedDescription)"
            print(error)
        }
    }


}
