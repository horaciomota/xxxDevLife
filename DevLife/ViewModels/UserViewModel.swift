    //
    //  UserViewModel.swift
    //  DevLife
    //
    //  Created by Horacio Mota on 07/11/23.
    //

    import Foundation
    import FirebaseFirestore
    import Combine

    class UserViewModel: ObservableObject {
        @Published var userID: String = UserDefaults.standard.string(forKey: "currentUserId") ?? ""
        @Published var userName: String = ""
        @Published var userAge: Int = 0
        @Published var decisions: [Decision] = []
        @Published var isUserDataFetched = false

        private var db = Firestore.firestore()
        private var decisionViewModel = DecisionViewModel()
        private var decisionsCancellable: AnyCancellable?

        init() {
            decisionsCancellable = $decisions
                .dropFirst() // Ignora o valor inicial do array para não salvar decisões que já estão carregadas.
                .sink { [weak self] newDecisions in
                    guard let self = self else { return }
                    for decision in newDecisions {
                        if !self.decisions.contains(where: { $0.id == decision.id }) {
                            // Salva a decisão no banco de dados
                            self.decisionViewModel.saveDecision(forUser: self.userID, decision: decision)
                        }
                    }
                }
        }

        func saveDecision(forUser userId: String, decision: Decision) {
            let decisionData = decision.dictionary
            if !self.decisions.contains(where: { $0.id == decision.id }) {
                // Salva a decisão no banco de dados
                self.decisionViewModel.saveDecision(forUser: self.userID, decision: decision)
            }
            db.collection("users").document(userId).collection("decisions").document(decision.id).setData(decisionData) { error in
                if let error = error {
                    print("Error saving decision: \(error.localizedDescription)")
                } else {
                    print("Decision saved successfully!")
                }
            }
        }

        func fetchUserDecisions(userId: String) async {
            do {
                // Atribua o resultado da função loadDecisions diretamente
                decisions = try await decisionViewModel.loadDecisions(forUser: userId)
            } catch {
                print("Error fetching decisions: \(error)")
            }
        }

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
                    self.isUserDataFetched = true
                } else {
                    print("Document does not exist")
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
