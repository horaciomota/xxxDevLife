import SwiftUI
import FloatingButton

struct HomeView: View {
    @EnvironmentObject var attributesViewModel: AttributesViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var creditsViewModel: CreditsViewModel
    @StateObject private var userViewModel = UserViewModel()


    @StateObject private var eventsViewModel = EventsViewModel()
    @StateObject private var homeViewModel = HomeViewModel()

    @State private var isFloatingButtonOpen = false
    @State private var isPlayerCreated = UserDefaults.standard.bool(forKey: "isCharacterCreated")

    @State private var userName: String = ""
     @State private var userAge: Int = 0
     @State private var userGender: String = ""

    var body: some View {
        Group {
            if isPlayerCreated {
                mainContentView
            } else {
                CreateUserView(isCharacterCreated: $isPlayerCreated)
            }
        }
        .onAppear {
            print("HomeView appeared")
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

                    // Exibe os registros do ano
                    if !homeViewModel.yearRecords.isEmpty {
                        ForEach(homeViewModel.yearRecords) { yearRecord in
                            Text("Year: \(yearRecord.year)")
                        }
                    } else {
                        Text("No year records found")
                    }

                    // Exibe os eventos
                    List(eventsViewModel.events) { event in
                        Button(action: {
                            if creditsViewModel.credits > 0 {
                                attributesViewModel.applyEventConsequences(event.consequences)
                                creditsViewModel.credits -= 1
                                print("Event selected: \(event.title)")
                            } else {
                                // Feedback para o usuário
                                print("Not enough credits to select this event")
                            }
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
    }
}
