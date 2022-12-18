//
//  Game.swift
//  GameList
//
//  Created by Burak Köse on 13.12.2022.
//

import Foundation

struct GameModel: Codable {
    var results: [GameResult]
}

 struct GameResult: Codable {
     var name: String
     var rating: Double
     var released: String
     var background_image: String
     var id: Int
}

struct GameDetailModel: Codable {
    var name: String
    var description: String
    var released: String
    var metacritic: Double
    var background_image: String
}
