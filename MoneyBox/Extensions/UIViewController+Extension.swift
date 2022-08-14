//
//  UIViewController+Extension.swift
//  MoneyBox
//
//  Created by Marc Jardine Esperas on 8/16/22.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "",
                   message: String,
                   buttonText: String = "Close",
                   style: UIAlertController.Style = .alert) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let action = UIAlertAction(title: buttonText, style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func hideNavigationbar() {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func showNavigationbar() {
        self.navigationItem.hidesBackButton = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
