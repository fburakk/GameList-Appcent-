//
//  ViewController.swift
//  GameList
//
//  Created by Burak Köse on 13.12.2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var gameCollectionViewModel = GameCollectionViewModel()
    private var gameWebservice = GameWebservice()
    
    private var gameNameArray = [GameResult]()
    private var filteredArray = [GameResult]()
    
    var chosenId = 0
    private var initalGamesImages = ["","",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegation()
        fetchData()
        hideKeyboard()
        Loading.shared.start(view: view)
    }
    
    //MARK: - Fetching Datas
    func fetchData() {
        gameWebservice.fetchGameData { [self] gameData in
            gameCollectionViewModel.update(gameData: gameData.results)
            
            gameNameArray = gameData.results
            
            initalGamesImages[0] = (gameData.results[0].background_image)
            initalGamesImages[1] = (gameData.results[1].background_image)
            initalGamesImages[2] = (gameData.results[2].background_image)
            
            collectionView.reloadData()
            Loading.shared.stop()
            
        } onFail: { error in
            Alert.shared.show(vc: self)
        }
        
    }
    //MARK: - Delegation
    func delegation() {
        collectionView.delegate = gameCollectionViewModel
        collectionView.dataSource = gameCollectionViewModel
        gameCollectionViewModel.sliderViewDelegate = self
        gameCollectionViewModel.outputDelegate = self
        searchBar.delegate = self
    }
    
    //MARK: - Hide Keyboard
    func hideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
}

//MARK: - Set SliderView
extension HomeVC: SliderViewModelDelegate {
    
    func setSliderView(sliderView: UIView) {
        let sliderViewModel = SliderViewModel(withImages: initalGamesImages)
        
        addChild(sliderViewModel)
        sliderView.addSubview(sliderViewModel.view)
        sliderViewModel.view.expandToParent(sliderView)
        sliderViewModel.didMove(toParent: self)
    }
}
//MARK: - CollectionView Clicked
extension HomeVC: GameCollectionViewModelOutput {
    
    func onClicked(id: Int) {
        chosenId = id
        performSegue(withIdentifier: "toDetailFromHome", sender: nil)
    }
}

//MARK: - Preapare for segue

extension HomeVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailFromHome" {
            let vc = segue.destination as! DetailVC
            vc.chosenId = chosenId
            
        }
    }
}

//MARK: - Search Bar
extension HomeVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let text = searchBar.text else {
            print("error")
            return
        }
        
        if text.count >= 3 {
            filteredArray = gameNameArray.filter({$0.name.contains(text)})
            
            if filteredArray.count == 0 {
                collectionView.isHidden = true
            }else {
                collectionView.isHidden = false
                gameCollectionViewModel.sliderHeight(isHidden: true)
                
                gameCollectionViewModel.update(gameData: filteredArray)
            }
            
        }else{
            collectionView.isHidden = false
            gameCollectionViewModel.sliderHeight(isHidden: false)
            filteredArray = gameNameArray
            
            gameCollectionViewModel.update(gameData: filteredArray)
            
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

