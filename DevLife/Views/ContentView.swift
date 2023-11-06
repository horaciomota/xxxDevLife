//
//  ContentView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = EventsViewModel()

    var body: some View {
        VStack {
            Text("Fetch Events")
                .onAppear {
                    viewModel.fetchEventsJson()
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
