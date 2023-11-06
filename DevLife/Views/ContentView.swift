//
//  HomeView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = EventsViewModel()

    private var attributes = [
        Attribute(name: "Joy", value: 50),
        Attribute(name: "Motivation", value: 5),
        Attribute(name: "Health", value: 5),
        Attribute(name: "Career", value: 5)
    ]

    var body: some View {
        VStack {
            ScrollView {
                AttributesView(attributes: attributes)
            }.onAppear {
                viewModel.fetchEventsJson()
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
