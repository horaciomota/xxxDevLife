//
//  CreateUserView.swift
//  DevLife
//
//  Created by Horacio Mota on 07/11/23.
//

import SwiftUI
import Firebase

struct CreateUserView: View {
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
        let userRef = db.collection("UserName: \(name)").document()

        let userData = [
            "UserName": name,
            "UserAge": Int(age) ?? 0,
            "UserGender": gender
        ] as [String : Any]

        userRef.setData(userData) { error in
            if let error = error {
                self.errorMessage = "Error saving user: \(error.localizedDescription)"
            } else {
                self.errorMessage = "User saved successfully!"
            }
        }
    }
}

#Preview {
    CreateUserView()
}
