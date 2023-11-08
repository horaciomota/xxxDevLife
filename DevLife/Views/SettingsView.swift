//
//  SettingsView.swift
//  DevLife
//
//  Created by Horacio Mota on 08/11/23.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var errorMessage: String? = nil
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Conta")) {
                    Text("Editar Perfil")
                    Text("Mudar Senha")
                    // Adicione mais opções de configurações de conta aqui
                }

                Section(header: Text("Geral")) {
                    Text("Notificações")
                    Text("Privacidade")
                    // Adicione mais opções de configurações gerais aqui
                }

                Section {
                    Button("Delete User", role: .destructive) {
                        deleteUser()
                    }
                }
                .alert("User Deleted", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                        // Redireciona para a página de criação de personagem
                        UserDefaults.standard.set(false, forKey: "isCharacterCreated")
                        presentationMode.wrappedValue.dismiss()
                    }
                } message: {
                    Text(errorMessage ?? "Your user has been successfully deleted.")
                }
            }
            .navigationTitle("Configurações")
        }
    }
    private func deleteUser() {
        guard let userId = UserDefaults.standard.string(forKey: "currentUserId") else {
            errorMessage = "Error: User ID not found."
            showAlert = true
            return
        }

        let db = Firestore.firestore()
        db.collection("users").document(userId).delete { error in
            if let error = error {
                errorMessage = "Error: \(error.localizedDescription)"
            } else {
                errorMessage = nil
                UserDefaults.standard.removeObject(forKey: "currentUserId")
                UserDefaults.standard.removeObject(forKey: "currentUserData")
                UserDefaults.standard.set(false, forKey: "isCharacterCreated")
            }
            showAlert = true
        }
    }
}

#Preview {
    CreateUserView(isCharacterCreated: .constant(true))
}
