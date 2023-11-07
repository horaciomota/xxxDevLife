import SwiftUI

struct HomeView: View {
    @EnvironmentObject var attributesViewModel: AttributesViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    @EnvironmentObject var creditsViewModel: CreditsViewModel

    @StateObject private var eventsViewModel = EventsViewModel()
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Exibe os atributos
                AttributesView(attributes: [
                    Attribute(name: "Joy", value: attributesViewModel.joy),
                    Attribute(name: "Motivation", value: attributesViewModel.motivation),
                    Attribute(name: "Health", value: attributesViewModel.health),
                    Attribute(name: "Career", value: attributesViewModel.career)
                ])

                // Exibe os créditos disponíveis
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
                            print("Not enough credits")
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
        }
        .onAppear {
            print("HomeView appeared")
            eventsViewModel.fetchAndHandleEventsJson()
            homeViewModel.loadYearRecords()
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AttributesViewModel()) // Garante que o AttributesViewModel esteja disponível
            .environmentObject(SharedDataModel()) // Garante que o SharedDataModel esteja disponível
            .environmentObject(CreditsViewModel()) // Garante que o CreditsViewModel esteja disponível
    }
}
