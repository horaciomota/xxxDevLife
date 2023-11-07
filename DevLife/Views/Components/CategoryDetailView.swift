import Foundation
import SwiftUI
import PopupView

struct CategoryDetailView: View {
    var category: Category
    @EnvironmentObject var creditsViewModel: CreditsViewModel
    @EnvironmentObject var attributesViewModel: AttributesViewModel
    @EnvironmentObject var sharedData: SharedDataModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingCreditAlert = false
    @State private var showingSuccessAlert = false

    var body: some View {
        List(category.items) { item in
            Button(action: {
                if creditsViewModel.credits >= item.cost {
                    // Aplica os atributos da habilidade
                    attributesViewModel.applySkillAttributes(item.attributes)
                    // Usa os créditos para adicionar a habilidade
                    creditsViewModel.useCredits(for: item)
                    // Adiciona a habilidade à lista de habilidades selecionadas
                    sharedData.selectedItems.append(item)
                    // Mostra o popup de sucesso
                    showingSuccessAlert = true
                    // Aguarda 2 segundos antes de fechar a vista
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        presentationMode.wrappedValue.dismiss()
                    }
                } else {
                    // Mostra o popup de alerta de créditos insuficientes
                    showingCreditAlert = true
                }
            }) {
                VStack(alignment: .leading) {
                    Text(item.name).font(.headline)
                    Text(item.description).font(.subheadline)
                    Text("Cost: \(item.cost)")
                }
            }
        }
        //        .navigationTitle(category.categoryName)
        .popup(isPresented: $showingCreditAlert) {
            createPopupView()
        } customize: {
            $0.autohideIn(2)
                .type(.floater(verticalPadding: 12, horizontalPadding: 12, useSafeAreaInset: true))
                .position(.bottom)
                .dragToDismiss(true)
                .animation(.easeInOut)
                .backgroundColor(.clear)
        }
        .popup(isPresented: $showingSuccessAlert) {
            SucessPopupView()
        } customize: {
            $0.autohideIn(2) // O popup desaparece automaticamente após 2 segundos
                .type(.floater(verticalPadding: 12, horizontalPadding: 12, useSafeAreaInset: true))
                .position(.bottom)
                .dragToDismiss(true)
                .animation(.easeInOut)
                .backgroundColor(.clear)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom) // Isso garante que o VStack não se expanda além do necessário

    }

    func createPopupView() -> some View {
        HStack {
            Image(systemName: "xmark.octagon.fill")
                .foregroundColor(.white)
                .imageScale(.large)

            Text("You don't have enough credits to add this skill.")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 80)
        .background(Color.red)
        .cornerRadius(20.0)
        .shadow(radius: 10)
    }

    func SucessPopupView() -> some View {
        HStack {
            Image(systemName: "checkmark.seal.fill") // Ícone de sucesso
                .foregroundColor(.white)
                .imageScale(.large)

            Text("Skill added successfully!")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 80)
        .background(Color.green) // Fundo verde para sucesso
        .cornerRadius(20.0)
        .shadow(radius: 10)
    }
}

// Previews
struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleCategory = Category(categoryName: "Example", description: "Example Description", items: [
            SkillItem(name: "Skill 1", description: "Description 1", attributes: [AttributeEffect(name: "joy", value: 1)], cost: 2),
            // Adicione mais SkillItems se necessário
        ])

        CategoryDetailView(category: exampleCategory)
            .environmentObject(AttributesViewModel())
            .environmentObject(SharedDataModel())
            .environmentObject(CreditsViewModel())
    }
}
