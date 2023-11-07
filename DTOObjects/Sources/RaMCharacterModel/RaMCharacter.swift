//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 04.09.2023.
//

import Foundation

public struct RaMCharacter: Codable, Identifiable {
    public let id: Int
    public let name: String
    public let status: String
    public let species: String
    public let type: String
    public let gender: String
    public let origin: RaMCharacterOrigin
    public let location: RaMCharacterLocation
    public let image: String
    public let episode: [String]
    public let url: String
    public let created: String
}
