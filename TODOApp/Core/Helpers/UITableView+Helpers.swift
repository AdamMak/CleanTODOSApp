//
//  UITableView+Helpers.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 07/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCustomCell<T: UITableViewCell & NibLoader>(cell: T.Type) {
        self.register(T.nib, forCellReuseIdentifier: T.identifier)
    }
}
