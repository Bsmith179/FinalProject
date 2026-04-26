//
//  ViewController.swift
//  FinalProject
//  A virtual friend to play with, be sure to take good care of it!
//  Created by Brigitte on 4/25/26.
//

import UIKit

class ViewController: UIViewController {

    // Outlets for stat #s for math testing
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hungerLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var boredomLabel: UILabel!
    @IBOutlet weak var cleanlinessLabel: UILabel!
    
    // Outlets for stat gauges
    @IBOutlet weak var hungerBar: UIProgressView!
    @IBOutlet weak var energyBar: UIProgressView!
    @IBOutlet weak var boredomBar: UIProgressView!
    @IBOutlet weak var cleanlinessBar: UIProgressView!
    
    
    var viewModel: PetViewModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create pet from Pet class starting stats
        viewModel = PetViewModel(pet: Pet(name: "Pett"))

        // Update the UI when the view model sends back changed information.
        viewModel.onUpdate = { [weak self] in
            self?.updateUI()
        }
        // First update on load to fill UI with the pet data before the user sees the screen
        updateUI()
    }

    // Update displayed visuals to most current values
    private func updateUI() {
        nameLabel.text = viewModel.nameText
        hungerLabel.text = viewModel.hungerText
        energyLabel.text = viewModel.energyText
        cleanlinessLabel.text = viewModel.cleanlinessText
        boredomLabel.text = viewModel.boredomText
        //happinessLabel.text = viewModel.happinessText
        //affectionLabel.text = viewModel.affectionText

        hungerBar.progress = viewModel.hungerProgress
        energyBar.progress = viewModel.energyProgress
        cleanlinessBar.progress = viewModel.cleanlinessProgress
        boredomBar.progress = viewModel.boredomProgress
    }

    // Interaction button responses
//    @IBAction func feedTapped(_ sender: UIButton) {
//        viewModel.feedPet()
//    }
//
//    @IBAction func playTapped(_ sender: UIButton) {
//        viewModel.playWithPet()
//    }
//
//    @IBAction func sleepTapped(_ sender: UIButton) {
//        viewModel.sleepPet()
//    }
//
//    @IBAction func batheTapped(_ sender: UIButton) {
//        viewModel.bathePet()
//    }
}
