//
//  UIViewController+Ext.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation


import UIKit

extension UIView {
    
    func setSubviewForAutoLayout(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)
    }
    
    func setSubviewsForAutoLayout(_ subviews: [UIView]) {
        subviews.forEach(self.setSubviewForAutoLayout)
    }
    
}

extension UIViewController {
    
    func presentOkAlert(title: String = "", message: String) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        presentAlert(title: title, message: message, preferredStyle: .alert, actionBtns: [okAction], dismissOnTap: false)
    }
    
    func presentAlert(title: String? = "", message: String?, preferredStyle: UIAlertController.Style = .alert, actionBtns: [UIAlertAction], dismissOnTap: Bool = false) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for btn in actionBtns {
            alert.addAction(btn)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
