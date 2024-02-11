//
//  PersistenceManager.swift
//  Simple_Viral_Games_Assignment
//
//  Created by Ayush Singh on 11/02/24.
//

import Foundation

class PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    static let capacity = 20
    
    static func updateWith(dogImageUrl: String) {
        var dogImageUrls = retrieveImages()
        if dogImageUrls.count == capacity {
            if let removedKey = dogImageUrls.popLast() {
                NetworkManager.shared.cache.removeObject(forKey: removedKey as NSString)
            }
        }
        dogImageUrls.insert(dogImageUrl, at: 0)
        save(imageUrls: dogImageUrls)
    }

    
    static func retrieveImages() -> [String] {
        let cachedKeys = defaults.object(forKey: Keys.cachedKeys) as? [String] ?? []
        return cachedKeys
    }
    
    static func save(imageUrls:[String]) {
        defaults.set(imageUrls, forKey: Keys.cachedKeys)
    }
    
    static func removeImages() {
        var dogImageUrls = retrieveImages()
        dogImageUrls.removeAll()
        save(imageUrls: dogImageUrls)
    }
}

