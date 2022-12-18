//
//  LoadingViewModel.swift
//  GameList
//
//  Created by Burak Köse on 18.12.2022.
//

import Foundation
import UIKit

class Loading {
    //Singleton
    static let shared = Loading()
    private init(){}
    
    private var activityView: UIActivityIndicatorView!
    
    func start(view: UIView) {
        activityView = UIActivityIndicatorView(style: .large)
        activityView.center = view.center
        view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func stop() {
        if (activityView != nil){
            activityView.stopAnimating()
        }
    }
}
