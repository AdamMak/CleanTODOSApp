//
//  NibLoader.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

protocol NibLoader {
    static var nib: UINib { get }
}

extension NibLoader where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
