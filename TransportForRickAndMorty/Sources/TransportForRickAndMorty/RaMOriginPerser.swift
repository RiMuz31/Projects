//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 06.10.2023.
//

import Foundation
import DTOObjects

class RaMOriginParser {
    func parsJSON(data: Data) throws -> RaMCharacterOrigin {
        let decoder = JSONDecoder()
        let characters = try decoder.decode(RaMCharacterOrigin.self, from: data)
        return characters
    }
}
