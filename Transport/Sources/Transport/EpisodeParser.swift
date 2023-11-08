//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 08.09.2023.
//

import Foundation
import DTOObjects

class EpisodeParser {
    func parsJSON(data: Data) throws -> EpisodeRM {
        let decoder = JSONDecoder()
        let characters = try decoder.decode(EpisodeRM.self, from: data)
        return characters
    }
}
