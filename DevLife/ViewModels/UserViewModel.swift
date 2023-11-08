//
//  UserViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 07/11/23.
//

import Foundation
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var userID: String = UserDefaults.standard.string(forKey: "currentUserId") ?? ""
    @Published var userName: String = ""
    @Published var userAge: Int = 0
    @Published var isUserDataFetched = false


    private var db = Firestore.firestore()

    func fetchUserData() {
        guard let userId = UserDefaults.standard.string(forKey: "currentUserId"), !userId.isEmpty else {
            print("UserID is empty, cannot fetch user data.")
            return
        }

        let userRef = db.collection("users").document(userId)

        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.userName = data?["UserName"] as? String ?? ""
                self.userAge = data?["UserAge"] as? Int ?? 0
            } else {
                print("Document does not exist")
            }
            DispatchQueue.main.async {
                    self.isUserDataFetched = true
                }

        }
    }
    

    func deleteUser(completion: @escaping (Bool) -> Void) {
        guard let userId = UserDefaults.standard.string(forKey: "currentUserId") else {
            print("UserID is empty, cannot delete user data.")
            completion(false)
            return
        }

        let userRef = db.collection("users").document(userId)
        userRef.delete() { error in
            if let error = error {
                print("Error removing user: \(error.localizedDescription)")
                completion(false)
            } else {
                print("User successfully removed!")
                completion(true)
            }
        }
    }
}
