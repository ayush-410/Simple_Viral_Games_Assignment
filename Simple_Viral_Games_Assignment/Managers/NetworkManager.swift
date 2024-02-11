//
//  NetworkManager.swift
//  Simple_Viral_Games_Assignment
//
//  Created by Ayush Singh on 09/02/24.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    private init() {}
    
    func getDogImage(completion: @escaping (Result<dogImage,APIError>) -> Void) {
        let urlString = EndPoint.Url
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            do {
                let dogImageUrl = try JSONDecoder().decode(dogImage.self, from: data)
                completion(.success(dogImageUrl))
            } catch {
                completion(.failure(.invalidData))
                return
            }
        }.resume()
    }
    
    func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200,
                    let data = data,
                    let image = UIImage(data: data) else {
                completion(nil)
                return }
            self.cache.setObject(image, forKey: cacheKey)
           completion(image)
        }
        task.resume()
    }
}
