//
//  SamplePokemon.swift
//  Dex3
//
//  Created by Jenil Jariwala on 2024-04-18.
//

import Foundation
import CoreData

struct SamplePokemon{
    
    static let samplePokemon = {
        let context = PersistenceController.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try! context.fetch(fetchRequest)
        return results.first!
    }()
    
}
