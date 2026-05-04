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
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create pet from Pet class starting stats or restore pet from previous session
        let pet = PetStorage.load() ?? Pet(name: "Pett")
        viewModel = PetViewModel(pet: pet)

        // Apply offline decay
        viewModel.refresh()
        
        
        // Update the UI when the view model sends back changed information.
        viewModel.onUpdate = { [weak self] in
            self?.updateUI()
        }
        
        // Set timer to manage interface updates
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.viewModel.refresh()
        }
        
        // First update on load to fill UI with the pet data before the user sees the screen
        viewModel.refresh()
    }
    
    // Handle updating stats when app is returned from the background
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refresh()
    }
        
    // Capture latest timestamp when app is closed to avoid lost data
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.refresh()
    }
    
    /// Update the visual display to the most current data.
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
    @IBAction func feedTapped(_ sender: UIButton) {
        viewModel.refresh()
        viewModel.feedPet()
    }
    
    @IBAction func petTapped(_ sender: UIButton) {
        viewModel.refresh()
        viewModel.petPet()
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        viewModel.refresh()
        viewModel.playWithPet()
    }
    
    @IBAction func sleepTapped(_ sender: UIButton) {
        viewModel.refresh()
        viewModel.sleepPet()
    }
    
    @IBAction func batheTapped(_ sender: UIButton) {
        viewModel.refresh()
        viewModel.bathePet()
    }
}
