//
//  CashDataEpisodesSingleton.swift
//  RickAndMorty
//
//  Created by Rinat Khaeritdinov on 19.09.2023.
//

import Foundation
import TransportForRickAndMorty
import DTOObjects

class CashDataEpisodes {
    static var shared = CashDataEpisodes()
    private var cashDict = [String:RaMEpisode]()
    private init () {}
    
    func getEpisode(from url:String) -> RaMEpisode? {
        return cashDict[url]
    }
    
    func setEpisode(_ episode: RaMEpisode, with url:String) {
        cashDict[url] = episode
    }
}
