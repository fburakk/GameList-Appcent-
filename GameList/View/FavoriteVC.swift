//
//  FavoriteVC.swift
//  GameList
//
//  Created by Burak Köse on 18.12.2022.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var favoriteCollectionViewModel = FavoriteCollectionViewModel()
    private var realmViewModel = RealmViewModel()
    
    var chosenId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegation()
        Loading.shared.start(view: view)
    }
    
    func delegation() {
        collectionView.delegate = favoriteCollectionViewModel
        collectionView.dataSource = favoriteCollectionViewModel
        favoriteCollectionViewModel.outputDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func fetchData() {
        favoriteCollectionViewModel.update(favoriteModel: realmViewModel.fetchData())
        collectionView.reloadData()
        Loading.shared.stop()
    }

}

extension FavoriteVC: FavoriteCollectionViewOutput {
    
    func onClicked(id: Int) {
        chosenId = id
        performSegue(withIdentifier: "toDetailFromFavorite", sender: nil)
    }
}

extension FavoriteVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFromFavorite" {
            let vc = segue.destination as! DetailVC
            vc.chosenId = chosenId
        }
    }
    
}
