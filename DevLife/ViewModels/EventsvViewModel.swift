//
//  EventsvViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation
import FirebaseStorage
import Combine

enum EventsError: Error {
    case downloadError(String)
    case decodeError(String)
}

class EventsViewModel: ObservableObject {
    @Published var events: [Event] = [] // Array cos os eventos do Json
    @Published var errorMessage: String? // Logica de tratamento de erros separada da view

    // Função assíncrona para buscar os dados do JSON
    func fetchEventsJson() async throws {
        let storage = Storage.storage()
        let eventsRef = storage.reference().child("FixedEvents.json")

        do {
            let data = try await eventsRef.data(maxSize: 1 * 1024 * 1024)

            // Decodificar o JSON em objetos Event
            let decoder = JSONDecoder()
            let container = try decoder.decode(EventsContainer.self, from: data)

            // Supondo que você queira todos os eventos de todos os anos em uma única lista
            let allEvents = container.events.values.flatMap { $0 }

            await MainActor.run {
                self.events = allEvents
            }
        } catch {
            print("Error: \(error)")
            throw EventsError.decodeError("Não foi possível decodificar os eventos: \(error.localizedDescription)")
        }
    }

    // Logica de tratamento de erros
    func fetchAndHandleEventsJson() {
            Task {
                do {
                    try await fetchEventsJson()
                } catch let error as EventsError {
                    switch error {
                    case .downloadError(let message), .decodeError(let message):
                        DispatchQueue.main.async {
                            self.errorMessage = message
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }


