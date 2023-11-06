//
//  Events.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation

struct Event: Identifiable, Codable {
    var id: Int
    var title: String
    var description: String
    var credits: Int
    var money: Int
    var consequences: [Consequence]
}

struct Consequence: Codable {
    var attribute: String
    var value: Int
}
