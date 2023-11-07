import SwiftUI

// CategoryDetailView.swift
struct CategoryDetailView: View {
    var category: Category
    @EnvironmentObject var creditsViewModel: CreditsViewModel
    @EnvironmentObject var attributesViewModel: AttributesViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List(category.items) { item in
            Button(action: {
                // Atualiza os atributos com base no item selecionado
                attributesViewModel.applySkillAttributes(item.attributes)

                // Tenta usar os créditos para adicionar a skill
                creditsViewModel.useCredits(for: item)

                // Adiciona o item ao array de itens selecionados se tiver créditos suficientes
                if creditsViewModel.credits >= item.cost {
                    sharedData.selectedItems.append(item)
                }

                // Fecha a CategoryDetailView e volta para a HomeView
                presentationMode.wrappedValue.dismiss()
            }) {
                VStack(alignment: .leading) {
                    Text(item.name).font(.headline)
                    Text(item.description).font(.subheadline)
                    Text("Cost: \(item.cost)") // Mostra o custo da skill
                }
            }
        }
        .navigationTitle(category.categoryName)
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleCategory = Category(categoryName: "Example", description: "Example Description", items: [
            SkillItem(name: "Skill 1", description: "Description 1", attributes: [AttributeEffect(name: "joy", value: 1)], cost: 5),
            // Adicione mais SkillItems se necessário
        ])

        CategoryDetailView(category: exampleCategory)
            .environmentObject(AttributesViewModel())
            .environmentObject(SharedDataModel())
            .environmentObject(CreditsViewModel())
    }
}
