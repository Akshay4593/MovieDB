//
//  EmptyErrorType.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

enum EmptyErrorType {
    case NoNetwork
    case Custom(title: String?, desc: String?, image: UIImage?, btnAction: String?)
    case OnlyTitle(title: String)
    case OnlyDesc(desc: String)
    
    
    var actionBtn: String? {
        switch self {
        case .OnlyTitle:
            return nil
        case .Custom(_, _, _, let btnAction):
            return btnAction
        default:
            return "Retry"
        }
    }
    
    var title: String? {
        switch self {
        case .Custom(let title, _, _, _):
            return title
        case .OnlyTitle(let title):
            return title
        case .OnlyDesc(_):
            return nil
        case .NoNetwork:
            return ""
        }
    }
    
    var desc: String? {
        switch self {
        case .Custom(_, let desc, _, _):
            return desc
        case .OnlyTitle(_):
            return nil
        case .OnlyDesc(let desc):
            return desc
        case .NoNetwork:
            return ""
        }
    }
    
    var image: UIImage? {
        switch self {
        case .NoNetwork:
            return UIImage(named: "")
        case .OnlyTitle(_), .OnlyDesc(_):
            return nil
        case .Custom(_, _, let image, _):
            return image
        }
    }
    
    func custom(title: String?, desc: String? = nil, image: UIImage? = nil, btnAction: String? = nil) -> EmptyErrorType {
        return .Custom(title: title, desc: desc, image: image, btnAction: btnAction)
    }
    
}
