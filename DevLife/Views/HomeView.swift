import SwiftUI
import FloatingButton

struct HomeView: View {
    @EnvironmentObject var attributesViewModel: AttributesViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var creditsViewModel: CreditsViewModel
    @EnvironmentObject var userViewModel: UserViewModel

    @StateObject private var eventsViewModel = EventsViewModel()
    @StateObject private var homeViewModel = HomeViewModel()

    @State private var isFloatingButtonOpen = false
    @State private var isPlayerCreated = UserDefaults.standard.bool(forKey: "isCharacterCreated")

    @State private var userName: String = ""
    @State private var userAge: Int = 0
    @State private var userGender: String = ""

    var body: some View {
        Group {
            if UserDefaults.standard.bool(forKey: "isCharacterCreated") {
                mainContentView
            } else {
                CreateUserView(isCharacterCreated: .constant(false))
            }
        }
        .onAppear {
            userViewModel.fetchUserData() // Isso carrega os dados do usuário quando a view aparece
            eventsViewModel.fetchAndHandleEventsJson()
            homeViewModel.loadYearRecords()
        }
    }

    var mainContentView: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Exibe os atributos
                    AttributesView(attributes: [
                        Attribute(name: "Joy", value: attributesViewModel.joy),
                        Attribute(name: "Motivation", value: attributesViewModel.motivation),
                        Attribute(name: "Health", value: attributesViewModel.health),
                        Attribute(name: "Career", value: attributesViewModel.career)
                    ])

                    // Exibe os créditos disponíveis
                    Text("Name: \(userViewModel.userName)")
                        .font(.headline)

                    Text("Age: \(userViewModel.userAge)")
                        .font(.headline)

                    Text("Credits: \(creditsViewModel.credits)")
                        .font(.headline)
                        .padding()

                    // Exibe os itens selecionados
                    if !sharedData.selectedItems.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Selected Skills").font(.title)
                            ForEach(sharedData.selectedItems) { item in
                                Text(item.name) // Mostra o nome do item selecionado
                            }
                        }
                    }

                    // Adicione esta seção para exibir as decisões
                    if !userViewModel.decisions.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Your Decisions").font(.title)
                            ForEach(userViewModel.decisions) { decision in
                                VStack(alignment: .leading) {
                                    Text(decision.title).font(.headline)
                                    Text(decision.details).font(.subheadline)
                                    Text("Date: \(decision.date.formatted())").font(.caption)
                                }
                            }
                        }
                    } else {
                        Text("No decisions found")
                    }
                }
                .padding()

                // Aqui é onde o FloatingButtonView é adicionado
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingButtonView(isOpen: $isFloatingButtonOpen)
                            .padding(20)
                    }
                }
            }
        }
    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AttributesViewModel())
            .environmentObject(SharedDataModel())
            .environmentObject(CreditsViewModel())
            .environmentObject(UserViewModel())
    }
}
