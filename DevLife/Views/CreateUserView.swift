import SwiftUI
import Firebase

struct CreateUserView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Binding var isCharacterCreated: Bool
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    @State private var errorMessage: String?

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
        }
    }

    private func saveUserInformation() {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(name)  // Modificado para usar uma coleção genérica

        let userData = [
            "UserName": name,
            "UserAge": Int(age) ?? 0,
            "UserGender": gender
        ] as [String : Any]

        // Salvar no Firestore
        userRef.setData(userData)

        // Salvar localmente
        UserDefaults.standard.set(userData, forKey: "currentUserData")

        userRef.setData(userData) { error in
            if let error = error {
                self.errorMessage = "Error saving user: \(error.localizedDescription)"
            } else {
                // Atualiza a flag no UserDefaults e o estado do Binding
                UserDefaults.standard.set(true, forKey: "isCharacterCreated")
                self.isCharacterCreated = true
                self.errorMessage = "User saved successfully!"
                // Aqui você pode adicionar uma navegação ou fechar a view atual, se necessário
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
