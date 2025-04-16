//
//  ViewedAnimalPersistence.swift
//  AnimalDex
//
//  Created by David Kabongo on 4/14/25.
//
import Foundation

class ViewedAnimalPersistence {
    static let key = "recentlyViewed"

    static func save(animal: Animal) {
        var viewed = load()
        
        // Remove duplicates by name
        viewed.removeAll { $0.name == animal.name }
        
        // Add to top of list
        viewed.insert(animal, at: 0)
        
        // Save trimmed to max 10
        let trimmed = Array(viewed.prefix(10))
        
        if let data = try? JSONEncoder().encode(trimmed) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func load() -> [Animal] {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Animal].self, from: data) {
            return decoded
        }
        return []
    }
}
