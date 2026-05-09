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
    var excitement: Double
    var happiness: Double
    var affection: Double
    
    var lastUpdate: Date
    var alreadyWarnedStats: Set<String> = []
    
    // Neglect penalty on stat recovery
    var hungerPenaltyUntil: Date?
    var energyPenaltyUntil: Date?
    var cleanlinessPenaltyUntil: Date?
    var excitementPenaltyUntil: Date?
    
    // Busy state for extended tasks
    var sleepUntil: Date?
    
    
    // Starter stats for new pet
    init(name: String) {
        self.name = name
        self.hunger = 85
        self.energy = 75
        self.cleanliness = 80
        self.excitement = 50
        self.happiness = 40
        self.affection = 0
        self.lastUpdate = Date()
    }
    
    
    func isSleeping(now: Date = Date()) -> Bool {
        if let sleepUntil = sleepUntil {
            return now < sleepUntil
        }
        return false
    }
    
    /// Feed your pet a tasty snack to help sate its hunger. This will surely improve it's mood but it might get a bit messy.
    func feed() {

        let hungerGain = applyRecoveryPenalty(
            to: hunger,
            amount: 15,
            penaltyUntil: hungerPenaltyUntil
        )

        hunger = min(hunger + hungerGain, 100)

        cleanliness = max(cleanliness - 5, 0)
    }
    
    /// Tuck your pet in for a nap before it gets cranky. Your pet will regain energy and wake up excited to
    ///play with you even more.
    func sleep() {

        sleepUntil = Date().addingTimeInterval(30)
        
        let energyGain = applyRecoveryPenalty(
            to: energy,
            amount: 30,
            penaltyUntil: energyPenaltyUntil
        )

        energy = min(energy + energyGain, 100)

        hunger = max(hunger - 10, 0)
        excitement = max(excitement - 8, 0)
    }
    
    /// Give your pet a relaxing bath to help it stay comfortably well groomed.
    func bathe() {

        let cleanlinessGain = applyRecoveryPenalty(
            to: cleanliness,
            amount: 35,
            penaltyUntil: cleanlinessPenaltyUntil
        )

        cleanliness = min(cleanliness + cleanlinessGain, 100)

        energy = max(energy - 5, 0)
    }
    
    /// Play with your pet with a toy to make it happier and help it expend some of its energy.
    func play() {
        
        let excitementGain = applyRecoveryPenalty(
            to: excitement,
            amount: 20,
            penaltyUntil: excitementPenaltyUntil
        )

        excitement = min(excitement + excitementGain, 100)

        energy = max(energy - 15, 0)
    }
    
    /// Pet your pet to slightly increase excitement.
    func pet() {

        let excitementGain = applyRecoveryPenalty(
            to: excitement,
            amount: 3,
            penaltyUntil: excitementPenaltyUntil
        )

        excitement = min(excitement + excitementGain, 100)

        energy = max(energy - 1, 0)
    }
    
    
    /// Simulation logic for time based stat decay.
    func updateStats(now: Date = Date()) {
        let timeScale = 30.0 // Running at 30x usual speed for demo
        let elapsed = now.timeIntervalSince(lastUpdate)
        
        let hungerDecay = 0.02
        let excitementDecay = 0.015
        let cleanlinessDecay = 0.01
        let energyRecovery = 0.01
        
        // Prevent expired busy state
        if let sleepUntil, now >= sleepUntil {
            self.sleepUntil = nil
        }

        
        // Timescaled stats formula for demo
        hunger = max(0, hunger - elapsed * hungerDecay * timeScale)
        excitement = max(0, excitement - elapsed * excitementDecay * timeScale)
        cleanliness = max(0, cleanliness - elapsed * cleanlinessDecay * timeScale)

        let allNeedsCritical =
            hunger == 0 &&
            excitement == 0 &&
            cleanliness == 0

        if allNeedsCritical {
            let energyDecay = 0.03
            energy = max(0, energy - elapsed * energyDecay * timeScale)
        } else {
            energy = min(100, energy + elapsed * energyRecovery * timeScale)
        }
        
        // 60 second long 50% stat re-gain debuff
        let penaltyDuration: TimeInterval = 60

        if hunger == 0 && hungerPenaltyUntil == nil {
            hungerPenaltyUntil = Date().addingTimeInterval(penaltyDuration)
        }

        if energy == 0 && energyPenaltyUntil == nil {
            energyPenaltyUntil = Date().addingTimeInterval(penaltyDuration)
        }

        if cleanliness == 0 && cleanlinessPenaltyUntil == nil {
            cleanlinessPenaltyUntil = Date().addingTimeInterval(penaltyDuration)
        }

        if excitement == 0 && excitementPenaltyUntil == nil {
            excitementPenaltyUntil = Date().addingTimeInterval(penaltyDuration)
        }
        
        lastUpdate = now
    }
    
    func checkLowStats() -> [String] {
        var warnings: [String] = []

        // Individual low stat warnings
        check(stat: hunger, name: "Hunger", warnings: &warnings)
        check(stat: energy, name: "Energy", warnings: &warnings)
        check(stat: cleanliness, name: "Cleanliness", warnings: &warnings)
        check(stat: excitement, name: "Excitement", warnings: &warnings)

        // Failure condition warning
        if isCritical() {
            if !alreadyWarnedStats.contains("Critical") {
                warnings.append("Your pet is depending on you! Help it or try again.")
                alreadyWarnedStats.insert("Critical")
            }
        } else {
            alreadyWarnedStats.remove("Critical")
        }
        
        return warnings
    }
    
    // Prevent continuous low stat notification spam
    private func check(stat: Double, name: String, warnings: inout [String]) {
        if stat <= 15 {
            if !alreadyWarnedStats.contains(name) {
                warnings.append("\(name) is low!")
                alreadyWarnedStats.insert(name)
            }
        } else {
            alreadyWarnedStats.remove(name)
        }
    }
    
    //Depleted all stats message
    func isCritical() -> Bool {
        return hunger == 0 &&
        energy == 0 &&
        cleanliness == 0 &&
        excitement == 0
    }
    
    private func applyRecoveryPenalty(
        to stat: Double,
        amount: Double,
        penaltyUntil: Date?
    ) -> Double {

        guard let penaltyUntil = penaltyUntil else {
            return amount
        }

        if Date() < penaltyUntil {
            return amount * 0.5
        }

        return amount
    }
    
    /// Demo action to fully restore all pet stats for a more versitile demonstration.
    func restoreAllStats() {
        hunger = 100
        energy = 100
        cleanliness = 100
        excitement = 100
        
        alreadyWarnedStats.removeAll()

        hungerPenaltyUntil = nil
        energyPenaltyUntil = nil
        cleanlinessPenaltyUntil = nil
        excitementPenaltyUntil = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case hunger
        case energy
        case cleanliness
        case excitement
        case happiness
        case affection
        case lastUpdate
        case alreadyWarnedStats
    }
    
}
