    //
    //  SkillsView.swift
    //  DevLife
    //
    //  Created by Horacio Mota on 06/11/23.
    //


    import SwiftUI

import SwiftUI

struct SkillsView: View {
    @StateObject private var viewModel = SkillsViewModel()
    @EnvironmentObject var attributesViewModel: AttributesViewModel // Use EnvironmentObject aqui
    @EnvironmentObject var sharedData: SharedDataModel

    var body: some View {
        NavigationView {
            List(viewModel.skillsData?.Skills ?? []) { category in
                NavigationLink(destination: CategoryDetailView(category: category)
                    .environmentObject(sharedData)
                    .environmentObject(attributesViewModel)) { // Passe o EnvironmentObject
                        Text(category.categoryName)
                    }
            }
            .navigationTitle("Skills")
            .onAppear {
                Task {
                    do {
                        try await viewModel.fetchSkillsJson()
                    } catch {
                        // Aqui você pode lidar com o erro, por exemplo, mostrando uma mensagem para o usuário
                        print("Erro ao buscar habilidades: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

// Não esqueça de adicionar o EnvironmentObject ao seu PreviewProvider se necessário
struct SkillsView_Previews: PreviewProvider {
    static var previews: some View {
        SkillsView()
            .environmentObject(SharedDataModel())
            .environmentObject(AttributesViewModel()) // Adicione isso também
    }
}
