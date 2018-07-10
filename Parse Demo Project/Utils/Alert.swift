//
//  Alert.swift
//  Parse Demo Project
//
//  Created by Marius Ilie on 05/07/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import UIKit

class Alert {
    class func present(withTitle title: String, message: String? = "", style: UIAlertControllerStyle = .alert, rootController: UIViewController? = NavigationManager.shared.rootController, actions: ([String: ((UIAlertAction)->())?]) = [:]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        actions.forEach({ (title, handler) in
            let action = UIAlertAction(title: title, style: .default, handler: handler)
            alertController.addAction(action)
        })
        
        if actions.count == 0 || style == .actionSheet {
            let action = UIAlertAction(title: "Close", style: .cancel, handler: nil)
            alertController.addAction(action)
        }
        
        rootController?.present(alertController, animated: true, completion: nil)
    }
}
