//
//  FavoriteModel.swift
//  GameList
//
//  Created by Burak Köse on 18.12.2022.
//

import Foundation
import RealmSwift

class FavoriteModel: Object {
    @Persisted var name: String = ""
    @Persisted var imageUrl: String = ""
    @Persisted var id: Int = 0
    
    convenience init(name: String, imageUrl: String,id: Int) {
        self.init()
        self.name = name
        self.imageUrl = imageUrl
        self.id = id
    }
}
