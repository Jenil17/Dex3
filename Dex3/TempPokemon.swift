//
//  TempPokemon.swift
//  Dex3
//
//  Created by Jenil Jariwala on 2024-04-11.
//

import Foundation
import SwiftUI

struct TempPokemon: Codable{
    let id: Int
    let name: String
    let types: [String]
    var hp: Int = 0
    var attack: Int = 0
    var defense: Int = 0
    var specialAttack: Int = 0
    var specialDefense: Int = 0
    var speed: Int = 0
    let sprite: URL
    let shiny: URL
    
    enum PokemonKeys: String, CodingKey{
        case id
        case name
        case types
        case stats
        case sprites
        
        enum TypeDictionaryKeys: String, CodingKey{
            case type
            
        enum TypeKeys: String, CodingKey{
            case name
            }
        }
        enum StatDicitionaryKeys: String, CodingKey{
            case value = "base_stat"
            case stat
            
            enum StatKeys: String, CodingKey{
                case name
            }
        }
        enum SpritKeys: String, CodingKey{
            case sprtie = "front_default"
            case shiny = "front_shiny"
        }
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PokemonKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
       
        var decodedTypes: [String] = []
        var typesContainer = try container.nestedUnkeyedContainer(forKey: .types)
        while !typesContainer.isAtEnd{
            let typesDictionaryContainer = try typesContainer.nestedContainer(keyedBy: PokemonKeys.TypeDictionaryKeys.self)
            let typeContainer = try typesDictionaryContainer.nestedContainer(keyedBy: PokemonKeys.TypeDictionaryKeys.TypeKeys.self, forKey: .type)
            
            let type = try typeContainer.decode(String.self, forKey: .name)
            decodedTypes.append(type)
            
        }
        types = decodedTypes
        var statsContaier = try container.nestedUnkeyedContainer(forKey: .stats)
        while !statsContaier.isAtEnd{
            let statsDictionaryContainer = try statsContaier.nestedContainer(keyedBy: PokemonKeys.StatDicitionaryKeys.self)
            let statContainer = try statsDictionaryContainer.nestedContainer(keyedBy: PokemonKeys.StatDicitionaryKeys.StatKeys.self, forKey: .stat)
            
            switch try statContainer.decode(String.self, forKey: .name){
            case "hp":
                hp = try statsDictionaryContainer.decode(Int.self, forKey: .value)
                
            case "attack":
                attack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
                
            case "defense":
                defense = try statsDictionaryContainer.decode(Int.self, forKey: .value)
                
            case "special-attack":
                specialAttack = try statsDictionaryContainer.decode(Int.self, forKey: .value)
                
            case "special-defense":
                specialDefense = try statsDictionaryContainer.decode(Int.self, forKey: .value)
                
            case "speed":
                speed = try statsDictionaryContainer.decode(Int.self, forKey: .value)
                
            default:
                print("IT will never get here")
                
            }
        }
        let spriteContainer = try container.nestedContainer(keyedBy: PokemonKeys.SpritKeys.self, forKey: .sprites)
        sprite = try spriteContainer.decode(URL.self, forKey: .sprtie)
        shiny  = try spriteContainer.decode(URL.self, forKey: .shiny)
        
    }
    
}
