//
//  AnimalFetcher.swift
//  AnimalDex
//
//  Created by David Kabongo on 4/13/25.
//

import Foundation
import UIKit

class AnimalFetcher {
    
    func createAnimalURL(animal: String) -> URL? {
        var components = URLComponents(string: "https://api.api-ninjas.com/v1/animals")
        components?.queryItems = [
            URLQueryItem(name: "name", value: animal)
        ]
        return components?.url
    }

    func getAllAnimals(input: String, completion: @escaping ([Animal]) -> Void) {
        guard let url = createAnimalURL(animal: input) else {
            completion([]) // Return empty array if URL fails
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("AoH2P/ma7u9ClUvT6VlVqQ==Mg8amZmu99fgrazM", forHTTPHeaderField: "X-Api-Key")

        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request failed:", error)
                completion([])
                return
            }

            guard let data = data else {
                print("No data returned")
                completion([])
                return
            }

            do {
                let decodedAnimals = try JSONDecoder().decode([Animal].self, from: data)
                completion(decodedAnimals)
            } catch {
                print("Decoding failed:", error)
                completion([])
            }
        }.resume()
    }
    
    func fetchUnsplashImage(for animal: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = createAnimalImageURL(animal: animal) else {
            print("Invalid image URL")
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Client-ID z2-_Looj6ess6Md8aATF4H-D3qX5iMx8Tp50uwyJQmo", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed request:", error)
                completion(nil)
                return
            }

            guard let data = data else {
                print("No data returned")
                completion(nil)
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let results = json["results"] as? [[String: Any]],
                   let firstResult = results.first,
                   let urls = firstResult["urls"] as? [String: Any],
                   let imageUrlString = urls["regular"] as? String,
                   let imageUrl = URL(string: imageUrlString) {

                    URLSession.shared.dataTask(with: imageUrl) { data, _, _ in
                        if let data = data, let image = UIImage(data: data) {
                            completion(image)
                        } else {
                            completion(nil)
                        }
                    }.resume()

                } else {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Unexpected JSON:", responseString)
                    } else {
                        print("Could not parse Unsplash response")
                    }
                    
                    completion(nil)
                }
            } catch {
                print("JSON error:", error)
                completion(nil)
            }
        }

        task.resume()
    }
    
    func createAnimalImageURL(animal: String) -> URL? {
        var components = URLComponents(string: "https://api.unsplash.com/search/photos")
        components?.queryItems = [
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "query", value: animal),
            URLQueryItem(name: "per_page", value: "1") // return only the first result
        ]
        return components?.url
    }
}
