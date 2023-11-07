//
//  UserViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 07/11/23.
//

import Foundation
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var userAge: Int = 0

    private var db = Firestore.firestore()

    func fetchUserData() {
        let userId = "id_do_usuario_atual"
        let userRef = db.collection("users").document(userId)

        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.userName = data?["UserName"] as? String ?? ""
                self.userAge = data?["UserAge"] as? Int ?? 0
            } else {
                print("Document does not exist")
            }
        }
    }
}
