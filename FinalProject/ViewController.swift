//
//  ViewController.swift
//  FinalProject
//  A virtual friend to play with, be sure to take good care of it!
//  Created by Brigitte on 4/25/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hungerLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var excitementLabel: UILabel!
    @IBOutlet weak var cleanlinessLabel: UILabel!
    
    // Outlets for stat gauges
    @IBOutlet weak var hungerBar: UIProgressView!
    @IBOutlet weak var energyBar: UIProgressView!
    @IBOutlet weak var excitementBar: UIProgressView!
    @IBOutlet weak var cleanlinessBar: UIProgressView!
    
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var petButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var sleepButton: UIButton!
    @IBOutlet weak var batheButton: UIButton!
    
    
    @IBAction func resetButton(_ sender: UIButton) {
        viewModel.restorePetStats()
    }
    
    var viewModel: PetViewModel!
    
    var timer: Timer?
    
    private var activeToasts: [UILabel] = []
    
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
        
        viewModel.onWarning = { [weak self] warnings in
            guard let self = self else { return }
            
            for warning in warnings {
                self.showToast(message: warning)
            }
        }
        
        // First update on load to fill UI with the pet data before the user sees the screen
        viewModel.refresh()
    }
    
    // Handle updating stats when app is returned from the background
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set timer to manage interface updates
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.viewModel.refresh()
        }
        
        viewModel.refresh()
    }
    
    // Capture latest timestamp when app is closed to avoid lost data
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop behavior and clear memory reference for timer when app is removed from focus
        timer?.invalidate()
        timer = nil
        
        viewModel.refresh()
    }
    
    /// Update the visual display to the most current data.
    private func updateUI() {
        nameLabel.text = viewModel.nameText
        hungerLabel.text = viewModel.hungerText
        energyLabel.text = viewModel.energyText
        cleanlinessLabel.text = viewModel.cleanlinessText
        excitementLabel.text = viewModel.excitementText
        //happinessLabel.text = viewModel.happinessText
        //affectionLabel.text = viewModel.affectionText
        
        hungerBar.progress = viewModel.hungerProgress
        energyBar.progress = viewModel.energyProgress
        cleanlinessBar.progress = viewModel.cleanlinessProgress
        excitementBar.progress = viewModel.excitementProgress
        
        sleepButton.isEnabled = !viewModel.isPetSleeping
        sleepButton.alpha = viewModel.isPetSleeping ? 0.4 : 1.0
    }
    
    
    
    // Interaction button responses
    @IBAction func feedTapped(_ sender: UIButton) {
        viewModel.feedPet()
    }
    
    @IBAction func petTapped(_ sender: UIButton) {
        viewModel.petPet()
    }
    
    @IBAction func playTapped(_ sender: UIButton) {
        viewModel.playWithPet()
    }
    
    @IBAction func sleepTapped(_ sender: UIButton) {
        viewModel.sleepPet()
    }
    
    @IBAction func batheTapped(_ sender: UIButton) {
        viewModel.bathePet()
    }
    
    //Toast-style needs message system
    private func showToast(message: String) {
        let toastLabel = UILabel()
        
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0
        
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let toastHeight: CGFloat = 50
        let toastWidth = self.view.frame.width - 80
        
        // Stack upward for each active toast
        let yOffset = CGFloat(activeToasts.count) * (toastHeight + 10)
        
        toastLabel.frame = CGRect(
            x: 40,
            y: self.view.frame.height - 120 - yOffset,
            width: toastWidth,
            height: toastHeight
        )
        
        self.view.addSubview(toastLabel)
        activeToasts.append(toastLabel)
        
        UIView.animate(withDuration: 0.3) {
            toastLabel.alpha = 1
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 3.0,
            options: [],
            animations: {
                toastLabel.alpha = 0
            },
            completion: { [weak self] _ in
                guard let self = self else { return }
                
                toastLabel.removeFromSuperview()
                
                // Remove from active array
                self.activeToasts.removeAll { $0 == toastLabel }
                
                // Re-stack remaining toasts downward
                UIView.animate(withDuration: 0.2) {
                    for (index, label) in self.activeToasts.enumerated() {
                        let newYOffset = CGFloat(index) * (toastHeight + 10)
                        
                        label.frame.origin.y =
                        self.view.frame.height - 120 - newYOffset
                    }
                }
            }
        )
    }
}
