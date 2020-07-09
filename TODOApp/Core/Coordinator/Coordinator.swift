//
//  Coordinator.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 07/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

class Coordinator {
    private(set) weak var presenter: Presentable?
    private(set) weak var displayedViewController: UIViewController?

    init(presenter: Presentable?) {
        self.presenter = presenter
    }

    func start() {
        fatalError("start() has not been implemented")
    }

    func show(_ viewController: UIViewController) {
        displayedViewController = viewController
        presenter?.show(viewController)
    }
}
