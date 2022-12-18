//
//  AlertViewModel.swift
//  GameList
//
//  Created by Burak Köse on 18.12.2022.
//

import Foundation
import UIKit

class Alert {
    // Singleton
    static let shared = Alert()
    private init() {}
    
    func show(vc:UIViewController) {
        let alert = UIAlertController(title: "Error!", message: "Something went wrong", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        vc.present(alert, animated: true)
    }
}
