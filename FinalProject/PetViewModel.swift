//
//  PetViewModel.swift
//  FinalProject
//  A virtual friend to play with, be sure to take good care of it!
//  Created by Brigitte on 4/25/26.
//

class PetViewModel {

    private var pet: Pet

    var onUpdate: (() -> Void)?
    var onWarning: (([String]) -> Void)?

    init(pet: Pet) {
        self.pet = pet
    }

    var nameText: String {
        pet.name
    }
    
    
    // Label text describing pet stat bars
    var hungerText: String {
        "Hunger:"
    }

    var energyText: String {
        "Energy:"
    }

    var cleanlinessText: String {
        "Cleanliness:"
    }

    var excitementText: String {
        "Excitement:"
    }
    
    var happinessText: String {
        "Happiness: \(pet.happiness)"
    }

    var affectionText: String {
        "Affection: \(pet.affection)"
    }
        
    var isPetSleeping: Bool {
        pet.isSleeping()
    }
    
    var canPlay: Bool {
        pet.canPlay()
    }
    
    // Need gauges values
    var hungerProgress: Float {
        Float(pet.hunger) / 100.0
    }

    var energyProgress: Float {
        Float(pet.energy) / 100.0
    }
    
    var cleanlinessProgress: Float {
        Float(pet.cleanliness) / 100.0
    }

    var excitementProgress: Float {
        Float(pet.excitement) / 100.0
    }
    

    // Call functions from the pet class
    func feedPet() {
        pet.feed()
        notify()
    }

    func playWithPet() {
        pet.play()
        notify()
    }

    func sleepPet() {
        pet.sleep()
        notify()
    }

    func bathePet() {
        pet.bathe()
        notify()
    }
    
    func petPet() {
        pet.pet()
        notify()
    }

    func refresh() {
        pet.updateStats()
        let warnings = pet.checkLowStats()
        if !warnings.isEmpty {
            onWarning?(warnings)
        }
        notify()
    }

    private func notify() {
        PetStorage.save(pet)
        onUpdate?()
    }
    
    func checkWarnings() -> [String] {
        return pet.checkLowStats()
    }

    func isCritical() -> Bool {
        return pet.isCritical()
    }
    
    func restorePetStats() {
        pet.restoreAllStats()
        notify()
    }
}

