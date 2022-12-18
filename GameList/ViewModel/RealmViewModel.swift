//
//  CoreDataViewModel.swift
//  GameList
//
//  Created by Burak Köse on 18.12.2022.
//

import Foundation
import UIKit
import RealmSwift


struct RealmViewModel {
    // Save game to favorite
    func saveData(favoriteGame:FavoriteModel) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.add(favoriteGame)
            }
        }catch let error as NSError {
            print(error)
        }
    }
    // Get game datas from favorites
    func fetchData() -> Results<FavoriteModel>{
        let realm = try! Realm()
        let favorites = realm.objects(FavoriteModel.self)
        
        return favorites
    }
    // Delete game data
    func deleteData(name:String) {
        let realm = try! Realm()
        
        do {
            try realm.write {
                realm.delete(realm.objects(FavoriteModel.self).filter("name=%@",name))
                print("deleted")
            }
            
        }catch let error as NSError {
            print(error)
        }
    }
    
}
