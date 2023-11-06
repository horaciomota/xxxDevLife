import SwiftUI

// CategoryDetailView.swift
struct CategoryDetailView: View {
    var category: Category
    @EnvironmentObject var attributesViewModel: AttributesViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        List(category.items) { item in
            Button(action: {
                // Atualiza os atributos com base no item selecionado
                attributesViewModel.applySkillAttributes(item.attributes)

                // Adiciona o item ao array de itens selecionados
                sharedData.selectedItems.append(item)

                // Fecha a CategoryDetailView e volta para a HomeView
                presentationMode.wrappedValue.dismiss()
            }) {
                VStack(alignment: .leading) {
                    Text(item.name).font(.headline)
                    Text(item.description).font(.subheadline)
                }
            }
        }
        .navigationTitle(category.categoryName)
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleCategory = Category(categoryName: "Example", description: "Example Description", items: [
            SkillItem(name: "Skill 1", description: "Description 1", attributes: [AttributeEffect(name: "joy", value: 1)]),
            // Adicione mais SkillItems se necessário
        ])

        CategoryDetailView(category: exampleCategory)
            .environmentObject(AttributesViewModel()) // Aqui está como você passa um EnvironmentObject
            .environmentObject(SharedDataModel()) // Se SharedDataModel também é necessário
    }
}
