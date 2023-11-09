//
//  DecisionViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 08/11/23.
//

import Foundation
import Firebase

class DecisionViewModel {
    private let db = Firestore.firestore()

    // Defina a função como async e que ela retorna um array de Decision
    func loadDecisions(forUser userId: String) async throws -> [Decision] {
        let querySnapshot = try await db.collection("users").document(userId).collection("decisions").getDocuments()

        var decisions: [Decision] = []
        for document in querySnapshot.documents {
            let data = document.data()
            let decision = Decision(
                id: data["id"] as? String ?? "",
                title: data["title"] as? String ?? "",
                date: (data["date"] as? Timestamp)?.dateValue() ?? Date(),
                details: data["details"] as? String ?? ""
            )
            decisions.append(decision)
        }
        return decisions
    }

    func saveDecision(forUser userId: String, decision: Decision) {
        let decisionData = [
            "id": decision.id,
            "title": decision.title,
            "details": decision.details,
            "date": Timestamp(date: decision.date)
        ] as [String : Any]

        db.collection("users").document(userId).collection("decisions").document(decision.id).setData(decisionData) { error in
            if let error = error {
                print("Error saving decision: \(error.localizedDescription)")
            } else {
                print("Decision saved successfully!")
            }
        }
    }

}

