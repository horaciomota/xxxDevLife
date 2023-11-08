import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var isCharacterCreated = UserDefaults.standard.bool(forKey: "isCharacterCreated")

    var body: some View {
        Group {
            if isCharacterCreated && userViewModel.isUserDataFetched {
                HomeView()
            } else {
                CreateUserView(isCharacterCreated: $isCharacterCreated)
            }
        }
        .onAppear {
            // Tenta buscar os dados do usuário ao carregar a view
            userViewModel.fetchUserData()
        }
        .onChange(of: userViewModel.isUserDataFetched) { isFetched in
            // Quando os dados do usuário são buscados, atualiza o estado de criação do personagem
            if isFetched {
                isCharacterCreated = true
            } else {
                isCharacterCreated = false
                UserDefaults.standard.set(false, forKey: "isCharacterCreated")
            }
        }
    }
}

// Para o preview, você precisará fornecer um EnvironmentObject falso
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
    }
}
