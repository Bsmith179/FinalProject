//
//  Pet.swift
//  FinalProject
//  A virtual friend to play with, be sure to take good care of it!
//  Created by Brigitte on 4/25/26.
//

import UIKit

class Pet {
    let name: String
    var hunger: Int
    var energy: Int
    var cleanliness: Int
    var boredom: Int
    var happiness: Int
    var affection: Int

    
    init(name: String,
         hunger: Int,
         energy: Int,
         cleanliness: Int,
         boredom: Int,
         happiness: Int,
         affection: Int) {
        
            self.name = name
            self.hunger = 85
            self.energy = 75
            self.cleanliness = 80
            self.boredom = 50
            self.happiness = 40
            self.affection = 0
    }
    
    func feed() {
        hunger = min(hunger + 15, 100)
    }
}
