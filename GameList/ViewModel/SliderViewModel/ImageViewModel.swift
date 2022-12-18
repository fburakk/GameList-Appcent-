//
//  ImageViewModel.swift
//  GameList
//
//  Created by Burak Köse on 14.12.2022.
//


import UIKit

class ImageViewModel: UIViewController {
    var image:String!
    var contentMode:UIView.ContentMode = .scaleAspectFill
    
    override func loadView() {
        view = UIView()
        
        let imageView = UIImageView()
        
        if let imageString = image as? String {
            imageView.sd_setImage(with: URL(string: imageString))
        }
        
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true
        
        view.addSubview(imageView)
        
        imageView.expandToParent(view)
    }
}
