//
//  FirestoreManager.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    func getAllYearRecords(completion: @escaping ([YearRecord]?, Error?) -> Void) {
        let collection = Firestore.firestore().collection("yearRecords")
        collection.getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
            } else if let documents = snapshot?.documents {
                let records = documents.compactMap { document -> YearRecord? in
                    // Tente criar um YearRecord a partir do documento
                    // Se não for possível, retorne nil
                    do {
                        let record = try document.data(as: YearRecord.self)
                        return record
                    } catch {
                        print("Error decoding document: \(error)")
                        return nil
                    }
                }
                completion(records, nil)
            } else {
                // Se não houver documentos ou snapshot for nil, retorne um array vazio
                completion([], nil)
            }
        }
    }
}


