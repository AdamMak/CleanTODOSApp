//
//  UIView+Helpers.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 07/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

protocol UIViewIdentifiable {
    static var identifier: String { get }
}

extension UIView : UIViewIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
