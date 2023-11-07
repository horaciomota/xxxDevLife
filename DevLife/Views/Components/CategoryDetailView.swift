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

    var body: some View {
        List(category.items) { item in
            Button(action: {
                if creditsViewModel.credits >= item.cost {
                    creditsViewModel.useCredits(for: item)
                    sharedData.selectedItems.append(item)
                    presentationMode.wrappedValue.dismiss()
                } else {
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
        .navigationTitle(category.categoryName)
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
