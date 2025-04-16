//
//  SearchViewController.swift
//  AnimalDex
//
//  Created by David Kabongo on 4/12/25.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var SearchTV: UITableView!
    
    let fetcher = AnimalFetcher()
    var searchResults: [Animal] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate = self
        SearchTV.delegate = self
        SearchTV.dataSource = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text?.lowercased(), !query.isEmpty else { return }

        searchBar.resignFirstResponder() // hides the keyboard

        fetcher.getAllAnimals(input: query) { [weak self] animals in
            DispatchQueue.main.async {
                print("Fetched \(animals.count) animals")
                self?.searchResults = animals
                self?.SearchTV.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTVCell", for: indexPath)
        let animal = searchResults[indexPath.row]
        cell.textLabel?.text = animal.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnimal = searchResults[indexPath.row]
        performSegue(withIdentifier: "SearchToDetail", sender: selectedAnimal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDetail" {
            if let destinationVC = segue.destination as? DetailViewController,
               let selectedAnimal = sender as? Animal {
                destinationVC.animal = selectedAnimal
            }
        }
    }
    
}
