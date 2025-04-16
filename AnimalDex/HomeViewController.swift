//
//  HomeViewController.swift
//  AnimalDex
//
//  Created by David Kabongo on 4/6/25.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var HomeView: UIView!
    @IBOutlet weak var RecentlySearchedTableView: UITableView!
    
    var recentlyViewedAnimals: [Animal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RecentlySearchedTableView.register(UINib(nibName: "MyRSCell", bundle: nil),
                                          forCellReuseIdentifier: MyRSCell.ID)
        
        
        RecentlySearchedTableView.dataSource = self
        RecentlySearchedTableView.delegate = self
                    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recentlyViewedAnimals = ViewedAnimalPersistence.load()
        RecentlySearchedTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnimal = recentlyViewedAnimals[indexPath.row]
        performSegue(withIdentifier: "RSToDetail", sender: selectedAnimal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows: \(recentlyViewedAnimals.count)")
        return recentlyViewedAnimals.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyRSCell.ID, for: indexPath) as? MyRSCell else {
            print("Failed to dequeue cell with identifier: \(MyRSCell.ID)")
            return UITableViewCell()
        }

        let animal = recentlyViewedAnimals[indexPath.row]
        
        cell.animal = animal  // This triggers updateUI() and sets the label/button
        
        // Force UI update explicitly (in case didSet is not triggering)
        cell.AnimalLabel?.text = animal.name.uppercased()
        cell.setFavoriteButtonLook()
        
        cell.selectionStyle = .none
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RSToDetail",
           let destinationVC = segue.destination as? DetailViewController,
           let selectedAnimal = sender as? Animal {
            destinationVC.animal = selectedAnimal
        }
    }
}
