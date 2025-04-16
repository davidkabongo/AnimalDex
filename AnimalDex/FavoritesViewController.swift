//
//  FavoritesViewController.swift
//  AnimalDex
//
//  Created by David Kabongo on 4/14/25.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var FavoritesTable: UITableView!
    
    var favoriteAnimals: [Animal] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            FavoritesTable.register(UINib(nibName: "MyRSCell", bundle: nil),
                                              forCellReuseIdentifier: MyRSCell.ID)
            
            FavoritesTable.dataSource = self
            FavoritesTable.delegate = self
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Load favorites every time view appears
            favoriteAnimals = AnimalPersistence().load()
            FavoritesTable.reloadData()
        }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favoriteAnimals.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRSCell.ID, for: indexPath) as? MyRSCell else {
            fatalError("Unable to dequeue MyRSCell")
        }
            
            let animal = favoriteAnimals[indexPath.row]
            cell.animal = animal
            return cell
        }
        
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnimal = favoriteAnimals[indexPath.row]
        performSegue(withIdentifier: "FavoritesToDetail", sender: selectedAnimal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FavoritesToDetail" {
            if let destinationVC = segue.destination as? DetailViewController,
               let selectedAnimal = sender as? Animal {
                destinationVC.animal = selectedAnimal
            }
        }
    }
}
