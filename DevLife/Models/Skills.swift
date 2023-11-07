//
//  Skills.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation

class SharedDataModel: ObservableObject {
    @Published var selectedItems: [SkillItem] = []
}

// Define the top-level structure that matches the JSON structure.
struct SkillsData: Codable {
    let Skills: [Category]
}

// Represents each category of skills, like "Programming Languages" or "Soft Skills".
struct Category: Codable, Identifiable {
    var id: String { categoryName }
    let categoryName: String
    let description: String
    let items: [SkillItem]
}

// Represents an individual skill within a category.
struct SkillItem: Codable, Identifiable {
    var id: String { name }
    let name: String
    let description: String
    let attributes: [AttributeEffect]
    let cost: Int
}

struct AttributeEffect: Codable {
    let name: String
    let value: Int
}


