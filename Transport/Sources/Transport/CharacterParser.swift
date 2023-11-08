//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 04.09.2023.
//

import Foundation
import DTOObjects

class CharacterParser {
    func parsJSON(data: Data) throws -> CharacterInfo {
        let decoder = JSONDecoder()
        let characters = try decoder.decode(CharacterInfo.self, from: data)
        return characters
    }
}

