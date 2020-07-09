//
//  TODOTableViewCell.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

class TODOTableViewCell: UITableViewCell, NibLoader {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var completedLabel: UILabel!

    func configure(with viewModel: TODOCellViewModel) {
        titleLabel.text = viewModel.title
        completedLabel.text = viewModel.completed
    }
    
}
