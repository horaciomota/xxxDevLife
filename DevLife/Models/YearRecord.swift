//
//  YearRecord.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation

struct YearRecord: Codable, Identifiable {
    var id: String
    var events: [Event]
    var decisions: [SkillItem]
    let year: Int
    // Adicione outros campos conforme necessário
}
