//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 08.09.2023.
//

import Foundation
import DTOObjects

class RaMEpisodeParser {
    func parsJSON(data: Data) throws -> RaMEpisode {
        let decoder = JSONDecoder()
        let characters = try decoder.decode(RaMEpisode.self, from: data)
        return characters
    }
}
