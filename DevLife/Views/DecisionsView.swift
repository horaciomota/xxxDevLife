//
//  DecisionsView.swift
//  DevLife
//
//  Created by Horacio Mota on 08/11/23.
//

import SwiftUI
import Firebase

struct DecisionsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    private let db = Firestore.firestore()


    var body: some View {
        List(userViewModel.decisions) { decision in
            VStack(alignment: .leading) {
                Text(decision.title).font(.headline)
                Text(decision.details).font(.subheadline)
                Text("Date: \(decision.date)").font(.caption)
            }
        }
        .task {
            await fetchUserDecisions()
        }
    }
    func fetchUserDecisions() async {
        guard let userId = UserDefaults.standard.string(forKey: "currentUserId"), !userId.isEmpty else {
            print("UserID is empty, cannot fetch user data.")
            return
        }
        await userViewModel.fetchUserDecisions(userId: userId)
    }
}


#Preview {
    DecisionsView()
        .environmentObject(UserViewModel())
}
