//
//  UIButton+Ext.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
}

extension UIButton {
    
    func setTitleForAllStates(_ title: String?) {
        setTitle(title, for: .normal)
        setTitle(title, for: .selected)
        setTitle(title, for: .disabled)
        setTitle(title, for: .focused)
        setTitle(title, for: .highlighted)
    }
    
}
