//
//  GameWebservice.swift
//  GameList
//
//  Created by Burak Köse on 13.12.2022.
//

import Foundation
import Alamofire

//MARK: - Api Key
private var apiKey = "?key=9939c7fbe83d4c9a9495cfc7e2a55d9e"

//MARK: - Json Path
private enum JsonPath: String {
    case games = "/games"
}

extension JsonPath  {
    func pathUrlToGame() -> String {
        return "https://api.rawg.io/api\(self.rawValue)\(apiKey)"
    }
    
    func pathUrlToDetail(id:String) -> String {
        return "https://api.rawg.io/api\(self.rawValue)/\(id)\(apiKey)"
    }
}
//MARK: - Webservice

struct GameWebservice {
 // Fetch Games
    func fetchGameData(onSucces: @escaping (GameModel) -> (),onFail: @escaping (String) -> ()) {
        AF.request(JsonPath.games.pathUrlToGame(), method: .get).validate().responseDecodable(of:GameModel.self) { response in
            
            guard let games = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSucces(games)
        }
        
    }
 
// Fetch Details
    func fetchGameDetail(id: String,onSucces: @escaping (GameDetailModel) -> (), onFail: @escaping (String) -> ()) {
        
        AF.request(JsonPath.games.pathUrlToDetail(id: id),method: .get).validate().responseDecodable(of: GameDetailModel.self) { response in
            
            guard let details = response.value else {
                onFail(response.debugDescription)
                return
            }
            
            onSucces(details)
        }
    }
    
}
