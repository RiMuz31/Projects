//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 04.09.2023.
//

import Foundation
import DTOObjects

class RaMCharacterParser {
    func parsJSON(data: Data) throws -> RaMCharacterInfo {
        let decoder = JSONDecoder()
        let characters = try decoder.decode(RaMCharacterInfo.self, from: data)
        return characters
    }
}

