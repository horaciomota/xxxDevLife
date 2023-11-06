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
            // Verifica se há uma mensagem de erro e a exibe
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            // Inclui component de estatistica
            AttributesView(attributes: attributes)

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
            viewModel.fetchAndHandleEventsJson()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
