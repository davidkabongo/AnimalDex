//
//  MyRSCell.swift
//  AnimalDex
//
//  Created by David Kabongo on 4/8/25.
//

import UIKit

class MyRSCell: UITableViewCell {
    
    static let ID = "RS_Cell"
    @IBOutlet weak var AnimalLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var animal: Animal? {
        didSet {
            updateUI()
        }
    }
    
    let persistence = AnimalPersistence()
    
    @IBAction func favoriteAnimal(_ sender: Any) {
        guard let animal = animal else { return }
        
        var savedAnimals = persistence.load()
        
        if savedAnimals.contains(where: { $0.name == animal.name }) {
            // Remove if already favorited
            savedAnimals.removeAll { $0.name == animal.name }
        } else {
            // Add if not already favorited
            savedAnimals.append(animal)
        }
        
        // Save updated list
        persistence.save(animals: savedAnimals)
        
        // Update the button look
        setFavoriteButtonLook()
    }
    
    func setFavoriteButtonLook() {
        guard let animal = animal else { return }
        
        let savedAnimals = persistence.load()
        let isFavorite = savedAnimals.contains(where: { $0.name == animal.name })
        
        let heartImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favoriteButton.setImage(heartImage, for: .normal)
    }
    
    private func updateUI() {
        guard let label = AnimalLabel else { return }
        label.text = animal?.name.uppercased()
        setFavoriteButtonLook()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        print("AnimalLabel: \(AnimalLabel == nil ? "nil" : "connected")")
        print("favoriteButton: \(favoriteButton == nil ? "nil" : "connected")")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
