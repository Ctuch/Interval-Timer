//
//  ModelData.swift
//  Interval Timer
//
//  Created by Clare Tuch on 1/24/24.
//

import Foundation

@Observable
class ModelData {
    var workouts: [Workout] = loadLocal("workouts.json") // Load local for testing purposes only
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    var file: URL
      
    do {
        file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(filename)
    } catch {
        fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        return [] as! T
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("Couldn't parse \(filename) as \(T.self):\n\(error)")
        return [] as! T
    }
}

func write<T: Codable>(array: [T], filename: String) {
    var file: URL
    do {
        file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(filename)
    } catch {
        fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
    }
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    do {
        print("Writing... \(file.description)")
        try encoder.encode(array).write(to: file)
    } catch {
        print("Couldn't save new nentry to \(filename), \(error.localizedDescription)")
    }
}

func loadLocal<T: Decodable>(_ filename: String) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
