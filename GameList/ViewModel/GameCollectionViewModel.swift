//
//  GameTableViewModel.swift
//  GameList
//
//  Created by Burak Köse on 13.12.2022.
//

import Foundation
import UIKit
import SDWebImage

//MARK: - Protocols
protocol GameCollectionViewModelDelegate {
    func update(gameData: [GameResult]?)
    func sliderHeight(isHidden: Bool) -> CGFloat
}

protocol GameCollectionViewModelOutput: AnyObject {
    func onClicked(id:Int)
}

protocol SliderViewModelDelegate: AnyObject {
    func setSliderView(sliderView: UIView)
}

//MARK: - CollectionView
class GameCollectionViewModel: NSObject {
    
    var games: [GameResult]?
    var isSliderHidden = false
    
    weak var sliderViewDelegate: SliderViewModelDelegate?
    weak var outputDelegate: GameCollectionViewModelOutput?
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
          // Static cell
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! SliderCell
            
            cell.sliderViewHeight.constant = sliderHeight(isHidden: isSliderHidden)
            cell.loadingLabel.isHidden = isSliderHidden
               
            sliderViewDelegate?.setSliderView(sliderView: cell.sliderView)
            return cell
            
          // Dynamic cell
        }else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCell
            
            cell.gameName.text = games?[indexPath.row].name
            cell.ratingLabel.text = "⭐️ \((games?[indexPath.row].rating) ?? 0.0)"
            cell.relasedLabel.text = "⏳ " + ((games?[indexPath.row].released) ?? "0.0.0")
            cell.gameImage.sd_setImage(with: URL(string: games?[indexPath.row].background_image ?? ""))
            
            return cell
                                                 
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = games?[indexPath.row].id ?? 0
        
        // Clicked
        outputDelegate?.onClicked(id: id)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Static cell
        if section == 0 {
            return 1
        }
        // Dynamic cell
        return games?.count ?? 0
    }
    
}
//MARK: - Extensions
extension GameCollectionViewModel: UICollectionViewDelegate,UICollectionViewDataSource {}

extension GameCollectionViewModel: GameCollectionViewModelDelegate {
    // Update colleciton view
    func update(gameData: [GameResult]?) {
        games = gameData
    }
    
    // Hide-Show Slider View
    func sliderHeight(isHidden: Bool) -> CGFloat {
        isSliderHidden = isHidden
        if isHidden {
            return 0
        }else{
            return 238
        }
    }
}
