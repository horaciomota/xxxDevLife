//
//  Skills.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation

struct SkillsData: Codable {
    let Skills: Skills
}

struct Skills: Codable {
    let Languages: SkillCategory
    let SoftSkills: SkillCategory
}

struct SkillCategory: Codable, Identifiable {
    let id = UUID()
    let description: String
    let options: [SkillOption]
}

struct SkillOption: Codable, Identifiable {
    let id: Int
    let name: String
    let consequences: [String: Int]
}

