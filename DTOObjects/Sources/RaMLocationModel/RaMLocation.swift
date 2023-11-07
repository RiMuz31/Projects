//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 13.09.2023.
//

import Foundation

public struct RaMLocation: Codable {
    
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [String]
    
}
