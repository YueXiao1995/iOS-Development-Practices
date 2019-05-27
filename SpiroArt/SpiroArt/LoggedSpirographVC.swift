//
//  LoggedSpirographVC.swift
//  SpiroArt
//
//  Created by YueXiao on 2019/3/31.
//  Copyright © 2019 COMP47390. All rights reserved.
//

import UIKit
class LoggedSpirographVC: SpirographVC, UIPopoverPresentationControllerDelegate {
    private let defaults = UserDefaults.standard
    
    
    


    

    
    override var spirographModel: SpirographModel {
        didSet { addButton.isEnabled = true }
    }
    

    
    
    var spirographLog: [SpirographModel] {
        set {
            let serializedLog = newValue.map { "\($0)" }
            defaults.set(serializedLog, forKey: Identifiers.defaultsKey)
            defaults.synchronize()
        }
        get {
            let serializedLog = defaults.object(forKey: Identifiers.defaultsKey) as? [String] ?? []
            return serializedLog.map { SpirographModel(fromText: $0)}
        }
    }
    
    private struct Identifiers {
        static let showFavoritesPopover = "showFavoritesPopover"
        static let defaultsKey = "SpiroArt.Favorites"
    }
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func addSpirographToFavorites(_ sender: UIBarButtonItem) {
        spirographLog.append(spirographModel)
        addButton.isEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Identifiers.showFavoritesPopover:
            if let favoritesVC = segue.destination as? FavoritesVC {
                favoritesVC.text = "\(spirographLog)"
                if let popover = favoritesVC.popoverPresentationController {
                    popover.delegate = self
                }
            }
        default:
            break
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    

}

extension SpirographModel {
    convenience init(fromText text: String) {
        self.init()
        let token = text.components(separatedBy: CharacterSet(charactersIn: " ="))
        print(token)
        self.M = Int(token[1])!
        self.N = Int(token[3])!
        self.F = Float(token[5])!
    }
}
