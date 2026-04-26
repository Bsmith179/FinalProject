//
//  Pet.swift
//  FinalProject
//  A virtual friend to play with, be sure to take good care of it!
//  Created by Brigitte on 4/25/26.
//

import UIKit

/// A class representing a virtual pet with stats representing its current needs.
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
        /// Feed your pet a tasty snack to help sate its hunger. This will surely improve it's mood but it might get a bit messy.
        func feed() {
//            hunger = min(hunger + 15, 100)
//            happiness = min(happiness + 5, 100)
//            cleanliness = max(cleanliness - 5, 0)
//            // Add chance of +1 affection point
        }
    
        /// Tuck your pet in for a nap before it gets cranky. Your pet will regain energy and wake up excited to
        ///play with you even more.
        func sleep() {
//            energy = min(energy + 30, 100)
//            hunger = max(hunger - 10, 0)
//            boredom = max(boredom - 8, 0)
        }

        /// Give your pet a relaxing bath to help it stay comfortably well groomed.
        func bathe() {
//            cleanliness = min(cleanliness + 35, 100)
//            happiness = min(happiness + 4, 100)
//            energy = max(energy - 5, 0)
//            //Add chance of +1 affection point
        }
        /// Play with your pet with a toy to make it happier and help it expend some of its energy.
        func play() {
//            boredom = min(boredom + 20, 100)
//            happiness = min(happiness + 15, 100)
//            affection = min(affection + 3, 100)
//            energy = max(energy - 15, 0)
//            //Add chance of +1 affection point
        }
        /// Pet your pet to slightly increase happiness and have a chance to gain a closer bond.
        func pet() {
            //happiness = min(happiness + 3, 100)
            //Add chance of +1 affection point
        }

        // Not actually implemented yet, just here to test the math when I hook up the buttons in Milestone 2.
        /// Logic for time based stat decay.
        func tick() {
//            hunger = max(hunger - 2, 0)
//            boredom = max(boredom - 2, 0)
//            cleanliness = max(cleanliness - 1, 0)
//            energy = min(energy + 1, 100)
//            happiness = max(happiness - 1, 0)
        }
    
}
