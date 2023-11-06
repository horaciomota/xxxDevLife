import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @StateObject private var eventsViewModel = EventsViewModel()
    @EnvironmentObject var attributesViewModel: AttributesViewModel
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        ScrollView {
            VStack {
                AttributesView(attributes: [
                    Attribute(name: "Joy", value: attributesViewModel.joy),
                    Attribute(name: "Motivation", value: attributesViewModel.motivation),
                    Attribute(name: "Health", value: attributesViewModel.health),
                    Attribute(name: "Career", value: attributesViewModel.career)
                ])

                // Adiciona uma visualização para os itens selecionados
                if !sharedData.selectedItems.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Selected Skills").font(.title)
                        ForEach(sharedData.selectedItems) { item in
                            Text(item.name) // Mostra o nome do item selecionado
                        }
                    }
                }

                if !homeViewModel.yearRecords.isEmpty {
                    ForEach(homeViewModel.yearRecords) { yearRecord in
                        Text("Year: \(yearRecord.year)")
                    }
                } else {
                    Text("No year records found")
                }

                List(eventsViewModel.events) { event in
                    Button(action: {
                        attributesViewModel.applyEventConsequences(event.consequences)
                        print("Event selected: \(event.title)")
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
    }
}

