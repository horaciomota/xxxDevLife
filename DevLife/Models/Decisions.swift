//
//  Decisions.swift
//  DevLife
//
//  Created by Horacio Mota on 08/11/23.
//

import Foundation
import Firebase


struct Decision: Identifiable, Codable {
    var id: String
    var title: String
    var date: Date
    var details: String

    // Dicionário para salvar no Firestore
    var dictionary: [String: Any] {
        return [
            "id": id,
            "title": title,
            "details": details,
            "date": Timestamp(date: date) // Converte Date para Timestamp do Firebase
        ]
    }

    // Inicializador que cria uma instância de Decision a partir de um dicionário do Firestore
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let title = dictionary["title"] as? String,
              let details = dictionary["details"] as? String,
              let timestamp = dictionary["date"] as? Timestamp else { return nil }

        self.id = id
        self.title = title
        self.details = details
        self.date = timestamp.dateValue()
    }

    // Inicializador para criar uma nova instância com valores padrão
    init(id: String = UUID().uuidString, title: String, date: Date, details: String) {
        self.id = id
        self.title = title
        self.date = date
        self.details = details
    }
}

