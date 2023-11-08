//
//  SettingsView.swift
//  DevLife
//
//  Created by Horacio Mota on 08/11/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isCharacterCreated: Bool
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
                            Button(action: {
                                userViewModel.deleteUser { success in
                                    if success {
                                        // Redefine o estado de criação do personagem
                                        isCharacterCreated = false
                                        // Remove os dados do usuário salvos localmente
                                        UserDefaults.standard.removeObject(forKey: "currentUserId")
                                        UserDefaults.standard.removeObject(forKey: "currentUserData")
                                        UserDefaults.standard.set(false, forKey: "isCharacterCreated")
                                        // Aqui você pode adicionar uma navegação ou fechar a view atual, se necessário
                                    }
                                }
                            }) {
                                Text("Deletar Usuário")
                                    .foregroundColor(.red)
                            }
                        }
            }
            .navigationTitle("Configurações")
        }
    }
}

#Preview {
    SettingsView(isCharacterCreated: .constant(true))
}
