//
//  FavoriteCollectionViewModel.swift
//  GameList
//
//  Created by Burak Köse on 18.12.2022.
//

import Foundation
import UIKit
import SDWebImage
import RealmSwift

//MARK: - Protocols
protocol FavoriteCollectionViewModelDelegate {
    func update(favoriteModel: Results<FavoriteModel>)
}

protocol FavoriteCollectionViewOutput: AnyObject {
    func onClicked(id:Int)
}

//MARK: - Collection View
class FavoriteCollectionViewModel: NSObject {
    
    var favoriteGame: Results<FavoriteModel>?
    weak var outputDelegate: FavoriteCollectionViewOutput?
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCell
        
        cell.gameImage.sd_setImage(with: URL(string:favoriteGame?[indexPath.row].imageUrl ?? ""))
        cell.nameLabel.text = favoriteGame?[indexPath.row].name ?? ""
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteGame?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Clicked
        outputDelegate?.onClicked(id: favoriteGame?[indexPath.row].id ?? 0)
    }
    
}

//MARK: - Extensions
extension FavoriteCollectionViewModel: UICollectionViewDelegate,UICollectionViewDataSource {}

extension FavoriteCollectionViewModel: FavoriteCollectionViewModelDelegate {
    func update(favoriteModel: Results<FavoriteModel>) {
        favoriteGame = favoriteModel
    }
}

