//
//  Skills.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation

struct SkillsData: Codable {
    let skills: [Category]

    enum CodingKeys: String, CodingKey {
        case skills = "Skills"
    }
}

struct Category: Codable {
    let categoryName: String
    let description: String
    let items: [SkillItem]
}

struct SkillItem: Codable, Identifiable {
    let id = UUID()
    let name: String
    let description: String
}

