//
//  Data.swift
//  Big 2 Tracker
//
//  Created by Luke Drushell on 5/31/21.
//


import Foundation
import SwiftUI
import CoreData

struct TheTotals: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "TheTotals"
    }
    var player1T: Int
    var player2T: Int
    var player3T: Int
    var player4T: Int
    var player5T: Int
    var player6T: Int
}

struct ColorTheme: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "ColorTheme"
    }
    
    var number: Int
    
}

struct DefaultPlayerCount: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "DefaultPlayerCount"
    }
    
    var number: Int
    
}

struct NumberOnePlayer: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "NumberOnePlayer"
    }
    var name: String
    var score: Int
}

struct LatestWinner: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "LatestWinner"
    }
    
    var name: String
    
}


struct TheAuthoritarianism: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "TheAuthoritarianism"
    }
    var player1T: Int
    var player2T: Int
    var player3T: Int
    var player4T: Int
    var player5T: Int
    var player6T: Int
}


struct TheSocialism: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "TheSocialism"
    }
    var player1T: Int
    var player2T: Int
    var player3T: Int
    var player4T: Int
    var player5T: Int
    var player6T: Int
}


struct TheDemocratic: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "TheDemocratic"
    }
    var player1T: Int
    var player2T: Int
    var player3T: Int
    var player4T: Int
    var player5T: Int
    var player6T: Int
}

struct TheCapitalism: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "TheCapitalism"
    }
    var player1T: Int
    var player2T: Int
    var player3T: Int
    var player4T: Int
    var player5T: Int
    var player6T: Int
}

struct TheEndScore: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "TheEndScore"
    }
    var endScore: Int
}


struct MatchInfo: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
        return "MatchInfo"
    }
    var theType: String
    var theWinner: String
    var theTime: String
    var id = UUID()
    var playercount: Int
    var player1Scores: [Int]
    var player2Scores: [Int]
    var player3Scores: [Int]
    var player4Scores: [Int]
    var player5Scores: [Int]
    var player6Scores: [Int]
    var theNames: [String]
}

struct Names: Hashable, Codable, LocalFileStorable {
    static var fileName: String {
            return "Names"
    }
    var p1Name: String
    var p2Name: String
    var p3Name: String
    var p4Name: String
    var p5Name: String
    var p6Name: String
}


protocol LocalFilesStorable: Codable {
    static var fileName: String { get }
}

extension LocalFilesStorable {
    static var localStorageURL: URL {
        guard let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Can NOT access file in Documents.")
        }
        
        return documentDirectory
            .appendingPathComponent(self.fileName)
            .appendingPathExtension("json")
    }
}

extension LocalFilesStorable {
    static func loadFromFile() -> [Self] {
        do {
            let fileWrapper = try FileWrapper(url: Self.localStorageURL, options: .immediate)
            guard let data = fileWrapper.regularFileContents else {
                throw NSError()
            }
            return try JSONDecoder().decode([Self].self, from: data)
            
        } catch _ {
            print("Could not load \(Self.self) the model uses an empty collection (NO DATA).")
            return []
        }
    }
}

extension LocalFilesStorable {
    static func saveToFile(_ collection: Self) {
        do {
            let data = try JSONEncoder().encode(collection)
            let jsonFileWrapper = FileWrapper(regularFileWithContents: data)
            try jsonFileWrapper.write(to: self.localStorageURL, options: .atomic, originalContentsURL: nil)
        } catch _ {
            print("Could not save \(Self.self)s to file named: \(self.localStorageURL.description)")
        }
    }
}

protocol LocalFileStorable: Codable {
    static var fileName: String { get }
}

extension LocalFileStorable {
    static var localStorageURL: URL {
        guard let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Can NOT access file in Documents.")
        }
        
        return documentDirectory
            .appendingPathComponent(self.fileName)
            .appendingPathExtension("json")
    }
}

extension LocalFileStorable {
    static func loadFromFile() -> [Self] {
        do {
            let fileWrapper = try FileWrapper(url: Self.localStorageURL, options: .immediate)
            guard let data = fileWrapper.regularFileContents else {
                throw NSError()
            }
            return try JSONDecoder().decode([Self].self, from: data)
            
        } catch _ {
            print("Could not load \(Self.self) the model uses an empty collection (NO DATA).")
            return []
        }
    }
}

extension LocalFileStorable {
    static func saveToFile(_ collection: [Self]) {
        do {
            let data = try JSONEncoder().encode(collection)
            let jsonFileWrapper = FileWrapper(regularFileWithContents: data)
            try jsonFileWrapper.write(to: self.localStorageURL, options: .atomic, originalContentsURL: nil)
        } catch _ {
            print("Could not save \(Self.self)s to file named: \(self.localStorageURL.description)")
        }
    }
}

extension Array where Element: LocalFileStorable {
    ///Saves an array of LocalFileStorables to a file in Documents
    func saveToFile() {
        Element.saveToFile(self)
    }
}
