import SwiftUI

struct CategoryDetailView: View {
    var category: Category
    @ObservedObject var attributesViewModel: AttributesViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    @Environment(\.presentationMode) var presentationMode // Adiciona o presentationMode

    var body: some View {
        List(category.items) { item in
            Button(action: {
                // Atualiza os atributos com base no item selecionado
                attributesViewModel.applySkillAttributes(item.attributes)

                // Adiciona o item ao array de itens selecionados
                sharedData.selectedItems.append(item)

                // Fecha a CategoryDetailView e volta para a HomeView
                self.presentationMode.wrappedValue.dismiss() // Chama o dismiss aqui
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

// Não esqueça de adicionar o EnvironmentObject ao seu PreviewProvider se necessário
struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailView(category: Category(categoryName: "Example", description: "Example Description", items: []), attributesViewModel: AttributesViewModel())
            .environmentObject(SharedDataModel())
    }
}
