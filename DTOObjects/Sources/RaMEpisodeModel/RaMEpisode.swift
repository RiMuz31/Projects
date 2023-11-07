//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 08.09.2023.
//

import Foundation

public struct RaMEpisode: Codable, Identifiable {
    
    func parseEpisodeString(_ episode: String) -> String {
        var array:[String] = [String]()
        var arrayInts:[Int] = [Int]()
        let textTopParse:String = episode + "N"
        var perem: String = ""
        for char in textTopParse {
            
            if char == "S" {
                continue
            }
            if char == "E" {
                array.append(perem)
                perem = ""
                continue
            }
            if char == "N" {
                array.append(perem)
                break
            }
            
            else {
                perem += String(char)
            }
        }
        
        for item in array {
            let intItem = Int(item)
            if let intItem = intItem {
                arrayInts.append(intItem)
            }
            
        }
        
        return "Episode: " + String(arrayInts[1]) + ", " + "Season: " + String(arrayInts[0])
    }
    
    public let id: Int?
    public var name: String?
    public var air_date: String?
    public var episode: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case air_date
        case episode
    }
    public init(from decoder: Decoder) throws {
        let conteiner = try decoder.container(keyedBy: CodingKeys.self)
        self.id = (try? conteiner.decode(Int?.self, forKey: .id)) ?? 00
        self.name = (try? conteiner.decode(String.self, forKey: .name)) ?? ""
        self.air_date = (try? conteiner.decode(String?.self, forKey: .air_date)) ?? ""
        let epis = try? conteiner.decode(String.self, forKey: .episode)
        if let epis = epis {
            self.episode = parseEpisodeString(epis)
        }
    }
}
