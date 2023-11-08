import SwiftUI
import Firebase

struct CreateUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isCharacterCreated: Bool
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    @State private var errorMessage: String?
    @State private var navigateToHomeView = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    Picker("Gender", selection: $gender) {
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Other").tag("Other")
                    }
                }

                Button("Save") {
                    saveUserInformation()
                }
                .disabled(name.isEmpty || age.isEmpty || gender.isEmpty)

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .navigationBarTitle("Create User")
            // Navegação programática para HomeView
            .background(
                NavigationLink(
                    destination: HomeView(),
                    isActive: $navigateToHomeView,
                    label: { EmptyView() } // Corrigido aqui
                )
            )
        }
    }

    private func saveUserInformation() {
        let db = Firestore.firestore()
        let userId = UUID().uuidString // Gera um novo UUID para o usuário
        let userRef = db.collection("users").document(userId)

        let userData = [
            "UserName": name,
            "UserAge": Int(age) ?? 0,
            "UserGender": gender
        ] as [String : Any]

        userRef.setData(userData) { error in
            if let error = error {
                self.errorMessage = "Error saving user: \(error.localizedDescription)"
            } else {
                UserDefaults.standard.set(userId, forKey: "currentUserId")
                UserDefaults.standard.set(userData, forKey: "currentUserData")
                UserDefaults.standard.set(true, forKey: "isCharacterCreated")
                self.isCharacterCreated = true
                self.navigateToHomeView = true // Ativa a navegação para HomeView
            }
        }
    }
}

// Para o preview, você precisará fornecer um Binding falso
struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView(isCharacterCreated: .constant(false))
            .environmentObject(AppViewModel())
    }
}
