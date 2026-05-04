//
//  PetStorage.swift
//  FinalProject
//  A virtual friend to play with, be sure to take good care of it!
//  Created by Brigitte on 5/4/26.
//

import Foundation

class PetStorage {
    private static let key = "saved_pet"

    static func save(_ pet: Pet) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(pet) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    static func load() -> Pet? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }

        let decoder = JSONDecoder()
        return try? decoder.decode(Pet.self, from: data)
    }
}
