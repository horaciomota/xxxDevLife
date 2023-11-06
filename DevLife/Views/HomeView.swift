//
//  HomeView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var eventsViewModel = EventsViewModel()
    @ObservedObject private var attributesViewModel = AttributesViewModel()
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            AttributesView(attributes: [
                Attribute(name: "Joy", value: attributesViewModel.joy),
                Attribute(name: "Motivation", value: attributesViewModel.motivation),
                Attribute(name: "Health", value: attributesViewModel.health),
                Attribute(name: "Career", value: attributesViewModel.career)
            ])

            List(eventsViewModel.events) { event in
                Button(action: {
                    attributesViewModel.applyEventConsequences(event.consequences)
                }) {
                    VStack(alignment: .leading) {
                        Text(event.title)
                            .font(.headline)
                        Text(event.description)
                            .font(.subheadline)
                    }
                }
            }

        }
        .onAppear {
            eventsViewModel.fetchAndHandleEventsJson()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
