//
//  CashDataEpisodesSingleton.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 19.09.2023.
//

import Foundation
import TransportForRickAndMorty

class CashDataEpisodes {
    static var shared = CashDataEpisodes()
    var cashDict = [String:RaMEpisode]()
    private init () {}
}
