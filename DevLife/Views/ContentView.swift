//
//  ContentView.swift
//  DevLife
//
//  Created by Horacio Mota on 07/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userViewModel = UserViewModel()
    @State private var isCharacterCreated = UserDefaults.standard.bool(forKey: "isCharacterCreated")

    var body: some View {
        Group {
            if isCharacterCreated && !userViewModel.userID.isEmpty {
                HomeView()
            } else {
                CreateUserView(isCharacterCreated: $isCharacterCreated)
            }
        }
        .onAppear {
            userViewModel.fetchUserData()
            if userViewModel.userID.isEmpty {
                isCharacterCreated = false
                UserDefaults.standard.set(false, forKey: "isCharacterCreated")
            }
        }
    }
}


#Preview {
    ContentView()
}
