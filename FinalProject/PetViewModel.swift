//
//  PetViewModel.swift
//  FinalProject
//  A virtual friend to play with, be sure to take good care of it!
//  Created by Brigitte on 4/25/26.
//

class PetViewModel {

    private var pet: Pet

    var onUpdate: (() -> Void)?

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

    var boredomText: String {
        "Boredom:"
    }
    
    var happinessText: String {
        "Happiness: \(pet.happiness)"
    }

    var affectionText: String {
        "Affection: \(pet.affection)"
    }
    
    
    // Test strings for debugging math
//    var hungerText: String {
//        "Hunger: \(pet.hunger)"
//    }
//
//    var energyText: String {
//        "Energy: \(pet.energy)"
//    }
//
//    var cleanlinessText: String {
//        "Cleanliness: \(pet.cleanliness)"
//    }
//
//    var boredomText: String {
//        "Boredom: \(pet.boredom)"
//    }
//    
//    var happinessText: String {
//        "Happiness: \(pet.happiness)"
//    }
//
//    var affectionText: String {
//        "Affection: \(pet.affection)"
//    }
    
    
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

    var boredomProgress: Float {
        Float(pet.boredom) / 100.0
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
        notify()
    }

    private func notify() {
        PetStorage.save(pet)
        onUpdate?()
    }
}

