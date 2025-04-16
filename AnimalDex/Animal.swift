//
//  Animal.swift
//  AnimalDex
//
//  Created by David Kabongo on 4/3/25.
//

import Foundation

struct Animals: Codable {
    let animals: [Animal]
    
    static func getAnimalsFromData(data: Data) -> Animals? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase 
        
        do {
            let animals = try decoder.decode(Animals.self, from: data)
            return animals
        } catch {
            print("Decoding failed:", error)
            return nil
        }
    }
}

struct Animal: Codable {
    let name: String
    let scientificName: String?
    let locations: [String]?
    let characteristics: Characteristics?
}

struct Characteristics: Codable {
    var estimatedPopulationSize: String?
    var habitat: String?
    var diet: String?
    var predators: String?
    var group: String?
    var lifespan: String?
    var weight: String?
    var height: String?
    
    func fullBodyText() -> String {
        var finalText = ""
        
        if let estimatedPopulationSize {
            finalText += "Estimated Population Size: \(estimatedPopulationSize)"
            finalText += "\n"
        }
        if let habitat {
            finalText += "Habitat: \(habitat)"
            finalText += "\n"
        }
        if let predators {
            finalText += "Predators: \(predators)"
            finalText += "\n"
        }
        if let group {
            finalText += "Group: \(group)"
            finalText += "\n"
        }
        if let lifespan {
            finalText += "Lifespan: \(lifespan)"
            finalText += "\n"
        }
        if let weight {
            finalText += "Weight: \(weight)"
            finalText += "\n"
        }
        
        if let height {
            finalText += "Height: \(height)"
            finalText += "\n"
        }
        return finalText
    }
}
