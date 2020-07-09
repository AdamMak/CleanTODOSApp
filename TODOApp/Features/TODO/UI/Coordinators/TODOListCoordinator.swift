//
//  TODOListCoordinator.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

class TODOListCoordinator: Coordinator {
    private let user: User

    init(presenter: Presentable?, user: User) {
        self.user = user

        super.init(presenter: presenter)
    }

    override func start() {
        let viewModel = TODOListViewModel(coordinator: self,
                                          usecase: GetTODOUseCase(),
                                          user: user)
        let viewController = TODOListViewController(viewModel: viewModel)
        show(viewController)
    }
}
