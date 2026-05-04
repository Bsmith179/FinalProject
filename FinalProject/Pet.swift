//
//  Pet.swift
//  FinalProject
//  A virtual friend to play with, be sure to take good care of it!
//  Created by Brigitte on 4/25/26.
//

import UIKit

/// A class representing a virtual pet with stats representing its current needs.
class Pet: Codable {
    let name: String
    var hunger: Double
    var energy: Double
    var cleanliness: Double
    var boredom: Double
    var happiness: Double
    var affection: Double
    
    var lastUpdate: Date

    // Starter stats for new pet
    init(name: String) {
        self.name = name
        self.hunger = 85
        self.energy = 75
        self.cleanliness = 80
        self.boredom = 50
        self.happiness = 40
        self.affection = 0
        self.lastUpdate = Date()
    }
    
        // Results of interaction (not final numbers, balance these later)
        /// Feed your pet a tasty snack to help sate its hunger. This will surely improve it's mood but it might get a bit messy.
        func feed() {
            hunger = min(hunger + 15, 100)
            happiness = min(happiness + 5, 100)
            cleanliness = max(cleanliness - 5, 0)
            // Add chance of +1 affection point
        }
    
        /// Tuck your pet in for a nap before it gets cranky. Your pet will regain energy and wake up excited to
        ///play with you even more.
        func sleep() {
            energy = min(energy + 30, 100)
            hunger = max(hunger - 10, 0)
            boredom = max(boredom - 8, 0)
        }

        /// Give your pet a relaxing bath to help it stay comfortably well groomed.
        func bathe() {
            cleanliness = min(cleanliness + 35, 100)
            happiness = min(happiness + 4, 100)
            energy = max(energy - 5, 0)
            //Add chance of +1 affection point
        }
        /// Play with your pet with a toy to make it happier and help it expend some of its energy.
        func play() {
            boredom = min(boredom + 20, 100)
            happiness = min(happiness + 15, 100)
            affection = min(affection + 3, 100)
            energy = max(energy - 15, 0)
            //Add chance of +1 affection point
        }
        /// Pet your pet to slightly increase happiness and have a chance to gain a closer bond.
        func pet() {
            happiness = min(happiness + 3, 100)
            //Add chance of +1 affection point
        }


    /// Simulation logic for time based stat decay.
    func updateStats(now: Date = Date()) {
        let timeScale = 10.0 // Running at 20x usual speed for demo
        let elapsed = now.timeIntervalSince(lastUpdate)

        let hungerDecay = 0.02
        let boredomDecay = 0.015
        let cleanlinessDecay = 0.01
        let happinessDecay = 0.01
        let energyRecovery = 0.005
        
        // Timescaled stats formula for demo
        hunger = max(0, hunger - elapsed * hungerDecay * timeScale)
        boredom = max(0, boredom - elapsed * boredomDecay * timeScale)
        cleanliness = max(0, cleanliness - elapsed * cleanlinessDecay * timeScale)
        happiness = max(0, happiness - elapsed * happinessDecay * timeScale)
        energy = min(100, energy + elapsed * energyRecovery * timeScale)

        // Original stats formula
//        hunger = max(0, hunger - elapsed * hungerDecay)
//        boredom = max(0, boredom - elapsed * boredomDecay)
//        cleanliness = max(0, cleanliness - elapsed * cleanlinessDecay)
//        happiness = max(0, happiness - elapsed * happinessDecay)
//        energy = min(100, energy + elapsed * energyRecovery)

        lastUpdate = now
    }
}
