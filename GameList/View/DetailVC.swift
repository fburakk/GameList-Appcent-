//
//  DetailVC.swift
//  GameList
//
//  Created by Burak Köse on 15.12.2022.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController {

    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var detailLabel: UITextView!
    
    @IBOutlet weak var favButtonOut: UIBarButtonItem!
    
    private var gameWebservice = GameWebservice()
    private var realmViewModel = RealmViewModel()
    
    var chosenId = 0
    private var isClicked = false
    
    var gameDetail: GameDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favButtonOut.image = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Loading.shared.start(view: view)
        nameLabel.text = ""
        dateLabel.text = ""
        rateLabel.text = ""
        detailLabel.text = ""
        
        fetchData { [self] data in
            gameDetail = data
            
            let description = data.description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            gameImage.sd_setImage(with: URL(string: data.background_image))
            nameLabel.text = data.name
            dateLabel.text = "Release Date: \(data.released)"
            rateLabel.text = "Metacritic Rate: \(data.metacritic)"
            detailLabel.text = description
            
            checkFavButton(name: data.name)
            Loading.shared.stop()
        }
    }
    
    //MARK: - Favorite Button Actions
    @IBAction func favButton(_ sender: Any) {
        isClicked = !isClicked
        
        favButtonOut.image = isClicked ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        print(isClicked)
        isClicked ? addFavorite() : removeFavorite()
    }
    
    func addFavorite() {
        realmViewModel.saveData(favoriteGame: FavoriteModel(name: gameDetail?.name ?? "", imageUrl: gameDetail?.background_image ?? "", id: chosenId))
    }
    
    func removeFavorite() {
        realmViewModel.deleteData(name: gameDetail?.name ?? "")
    }
    
    func checkFavButton(name:String){
        favButtonOut.image = UIImage(systemName: "star")
        
        let results = realmViewModel.fetchData()
        for i in results {
            if i.name == name {
                favButtonOut.image = UIImage(systemName: "star.fill")
                isClicked = true
            }
        }
    }
    
    
    
    //MARK: - Fetching Datas
    func fetchData(completion: @escaping(GameDetailModel) -> ()) {
        gameWebservice.fetchGameDetail(id: String(chosenId)) { data in
            
            let gameDetail = GameDetailModel(name: data.name, description: data.description, released: data.released, metacritic: data.metacritic, background_image: data.background_image)
            
            completion(gameDetail)
            
        } onFail: { error in
            Alert.shared.show(vc: self)
        }
    }
}
