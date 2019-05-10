//
//  StarController.swift
//  Stars
//
//  Created by Stephanie Bowles on 5/10/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import Foundation


class StarController {
    
    init() {
        self.loadFromPersistenceStore()
    }
    private(set) var stars: [Star] = []
    
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask) .first else {return nil}
        //Users/stephanie/documents
        
        return documentsDirectory.appendingPathComponent("stars.plist")
        
        //Users/stephanie/documents
    }
    func addStar(named name: String, withDistance distance: Double) {
        let star = Star(name: name, distance: distance)
        stars.append(star)
        saveToPersistenceStore()
    }
    //use do try catch with anything that uses "throw"
    func saveToPersistenceStore() {
        guard let url = self.persistentFileURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(stars)
            try data.write(to: url)
        } catch {
            NSLog("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        let fileManager = FileManager.default
        guard let url = persistentFileURL,
            fileManager.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            self.stars = try decoder.decode([Star].self, from: data)
            
        } catch {
            NSLog("Error loading stars data: \(error)")
            
        }
    }
}
