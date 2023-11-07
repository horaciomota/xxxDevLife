//
//  HomeViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Combine
import Foundation

class HomeViewModel: ObservableObject {
    @Published var yearRecords: [YearRecord] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    private var firestoreManager = FirestoreManager()
    // ...

    func loadYearRecords() {
        isLoading = true
        firestoreManager.getAllYearRecords { [weak self] (records: [YearRecord]?, error: Error?) in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let records = records {
                    self?.yearRecords = records
                    print("Year records loaded: \(records)")
                } else if let error = error {
                    self?.errorMessage = "Erro ao carregar registros: \(error.localizedDescription)"
                    print(self?.errorMessage ?? "Unknown error")
                }
            }
        }
    }
}


