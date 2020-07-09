//
//  UserListCoordinator.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit

class UserListCoordinator: Coordinator {
    override func start() {
        let viewModel = UserListViewModel(coordinator: self, usecase: GetUsersUseCase())
        let viewController = UserListViewController(viewModel: viewModel)
        show(viewController)
    }

    func showTODOs(user: User) {
        let coordinator = TODOListCoordinator(presenter: presenter, user: user)
        coordinator.start()
    }
}
