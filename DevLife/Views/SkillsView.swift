//
//  SkillsView.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//


import SwiftUI

struct SkillsView: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = SkillsViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.skillsData?.Skills ?? []) { category in
                    Section(header: Text(category.categoryName)) {
                        ForEach(category.items) { item in
                            Button(action: {
                                // Adicione o item selecionado ao modelo de dados compartilhado
                                sharedData.selectedItems.append(item)
                                // Atualize os atributos se necessário
                                // attributesViewModel.updateAttributes(with: item)
                                // Dismiss the current view to go back to the HomeView
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                VStack(alignment: .leading) {
                                    Text(item.name).font(.headline)
                                    Text(item.description).font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Skills")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onAppear {
                Task {
                    do {
                        try await viewModel.fetchSkillsJson()
                    } catch {
                        print("Erro ao buscar habilidades: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}


#Preview {
    SkillsView()
        .environmentObject(SharedDataModel())
}
