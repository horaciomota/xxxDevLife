//
//  CreditAlertView.swift
//  DevLife
//
//  Created by Horacio Mota on 07/11/23.
//

import SwiftUI

struct CreditAlertView: View {

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Not Enough Credits")
                .font(.headline)
                .foregroundColor(.white)
            Text("You don't have enough credits to add this skill.")
                .foregroundColor(.white)
            Button("OK") {
                // Ação para fechar o Sheet
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.9))
        .cornerRadius(10)
        .shadow(radius: 5)
        .edgesIgnoringSafeArea(.all) // Ignora as áreas de segurança para usar todo o espaço disponível na parte inferior
    }
}



#Preview {
    CreditAlertView()
}
