//
//  AnimalPersistence.swift
//  AnimalDex
//
//  Created by David Kabongo on 4/14/25.
//

import Foundation

class AnimalPersistence {
    
    let key = "favorites"
        
    func save(animals: [Animal]) {
            if let data = try? JSONEncoder().encode(animals) {
                UserDefaults.standard.set(data, forKey: key)
            }
        }
        
    func load() -> [Animal] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Animal].self, from: data) else {
            return []
        }
        return decoded
    }
    
}
