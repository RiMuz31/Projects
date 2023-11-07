//
//  File.swift
//  
//
//  Created by Rinat Khaeritdinov on 04.09.2023.
//

import Foundation

public struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
