//
//  Events.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation

struct EventsContainer: Codable {
    let events: [String: [Event]]
}

struct Event: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let credits: Int
    let money: Int
    let consequences: [Consequence]
}

struct Consequence: Codable {
    let attribute: String
    let value: Int
}
