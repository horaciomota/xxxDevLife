//
//  AttributesViewModel.swift
//  DevLife
//
//  Created by Horacio Mota on 06/11/23.
//

import Foundation

class AttributesViewModel: ObservableObject {
    @Published var joy: Int = 5
    @Published var motivation: Int = 5
    @Published var health: Int = 5
    @Published var career: Int = 5

    func applyEventConsequences(_ consequences: [Consequence]) {
        for consequence in consequences {
            switch consequence.attribute {
            case "joy":
                joy += consequence.value
            case "motivation":
                motivation += consequence.value
            case "health":
                health += consequence.value
            case "career":
                career += consequence.value
            default:
                break
            }
        }
    }

    func applySkillAttributes(_ attributes: [AttributeEffect]) {
          for attribute in attributes {
              switch attribute.name {
              case "joy":
                  joy += attribute.value
              case "motivation":
                  motivation += attribute.value
              case "health":
                  health += attribute.value
              case "career":
                  career += attribute.value
              default:
                  break
              }
          }
      }
  }

