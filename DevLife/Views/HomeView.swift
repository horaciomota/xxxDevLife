//
//  HomeView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = EventsViewModel()
    @State private var errorMessage: String?

    private var attributes = [
        Attribute(name: "Joy", value: 50),
        Attribute(name: "Motivation", value: 5),
        Attribute(name: "Health", value: 5),
        Attribute(name: "Career", value: 5)
    ]

    var body: some View {
        VStack {
            AttributesView(attributes: attributes)

            if let errorMessage = errorMessage {
                Text("Erro: \(errorMessage)")
                    .foregroundColor(.red)
            }

            List(viewModel.events) { event in
                VStack(alignment: .leading) {
                    Text(event.title)
                        .font(.headline)
                    Text(event.description)
                        .font(.subheadline)
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchEventsJson()
                } catch {
                    if let eventsError = error as? EventsError {
                        switch eventsError {
                        case .downloadError(let message), .decodeError(let message):
                            self.errorMessage = message
                        }
                    } else {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
        .padding()
    }
}


// Certifique-se de que o nome do método chamado no .onAppear() está correto.
// Deve corresponder ao nome do método dentro do seu ViewModel que inicia o processo de carregamento dos eventos.


#Preview {
    HomeView()
}
