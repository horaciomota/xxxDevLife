import SwiftUI

struct TabBarView: View {
    @StateObject var sharedData = SharedDataModel()
    @StateObject var userViewModel = UserViewModel()
    @State private var isCharacterCreated = UserDefaults.standard.bool(forKey: "isCharacterCreated")

    var body: some View {
        Group {
            if isCharacterCreated {
                tabView
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
        .environmentObject(sharedData)
        .environmentObject(userViewModel)
    }

    var tabView: some View {
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
                SettingsView(isCharacterCreated: .constant(true))
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
