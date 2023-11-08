//
//  TabBarView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var sharedData = SharedDataModel()

    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            NavigationView {
                SkillsView()
            }
            .tabItem {
                Label("Skills", systemImage: "list.bullet")
            }

            NavigationView {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
        .environmentObject(sharedData)
    }
}


#Preview {
    TabBarView()

}
