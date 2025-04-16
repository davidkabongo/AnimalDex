//
//  DetailViewController.swift
//  AnimalDex
//
//  Created by David Kabongo on 4/12/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var AnimalDetails: UILabel!
    
    var animal: Animal?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let animal = animal {
            AnimalDetails.text = animal.characteristics?.fullBodyText()
            ViewedAnimalPersistence.save(animal: animal)

            AnimalFetcher().fetchUnsplashImage(for: animal.name) { fetchedImage in
                DispatchQueue.main.async {
                    self.image.image = fetchedImage
                }
            }
        }
    }
    
    
    
    func fetchImage(for animalName: String, completion: @escaping (UIImage?) -> Void) {
        
        let formattedName = animalName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? animalName
        let urlString = "https://source.unsplash.com/600x400/?\(formattedName)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        // Download the image
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }

            completion(image)
        }
        
        task.resume()
    }

}
