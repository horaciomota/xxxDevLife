//
//  EventsvViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import FirebaseStorage
import Combine

class EventsViewModel: ObservableObject {
    @Published var events: [Event] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchEventsJson() {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let eventsRef = storageRef.child("FixedEvents.json") // Caminho do arquivo no Firebase Storage

        // Baixar os dados
        eventsRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Um erro ocorreu!
                print("Error fetching events: \(error)")
            } else if let data = data {
                // Dados recebidos
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON String: \(jsonString)")
                    // Aqui você pode adicionar a lógica para converter o jsonString em objetos Event
                }
            }
        }
    }
}
