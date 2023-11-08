//
//  SettingsView.swift
//  DevLife
//
//  Created by Horacio Mota on 08/11/23.
//

import SwiftUI

struct SettingsView: View {
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
                        // A lógica para deletar o usuário será adicionada aqui
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
    SettingsView()
}
