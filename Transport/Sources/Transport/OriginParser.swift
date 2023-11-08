//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 07.11.2023.
//

import Foundation
import DTOObjects

class OriginParser {
    func parsJSON(data: Data) throws -> CharacterOrigin {
        let decoder = JSONDecoder()
        let characters = try decoder.decode(CharacterOrigin.self, from: data)
        return characters
    }
}
