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

    // Starter stats for new pet
    init(name: String) {
            self.name = name
            self.hunger = 85
            self.energy = 75
            self.cleanliness = 80
            self.boredom = 50
            self.happiness = 40
            self.affection = 0
    }
    
        // Results of interaction (not final numbers, balance these later)
        func feed() {
//            hunger = min(hunger + 15, 100)
//            happiness = min(happiness + 5, 100)
//            cleanliness = max(cleanliness - 5, 0)
//            // Add chance of +1 affection point
        }

        func sleep() {
//            energy = min(energy + 30, 100)
//            hunger = max(hunger - 10, 0)
//            boredom = max(boredom - 8, 0)
        }

        func bathe() {
//            cleanliness = min(cleanliness + 35, 100)
//            happiness = min(happiness + 4, 100)
//            energy = max(energy - 5, 0)
//            //Add chance of +1 affection point
        }

        func play() {
//            boredom = min(boredom + 20, 100)
//            happiness = min(happiness + 15, 100)
//            affection = min(affection + 3, 100)
//            energy = max(energy - 15, 0)
//            //Add chance of +1 affection point
        }
    
        func pet() {
            //happiness = min(happiness + 3, 100)
            //Add chance of +1 affection point
        }


        func tick() {
//            hunger = max(hunger - 2, 0)
//            boredom = max(boredom - 2, 0)
//            cleanliness = max(cleanliness - 1, 0)
//            energy = min(energy + 1, 100)
//            happiness = max(happiness - 1, 0)
        }
    
}
