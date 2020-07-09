//
//  UserListCoordinatorSpec.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import TODOApp

class UserListCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("start") {
            var coordinator: UserListCoordinator!
            var navigationController: UINavigationController!

            beforeEach {
                navigationController = UINavigationController()
                coordinator = UserListCoordinator(presenter: navigationController)
                coordinator.start()
                UIApplication.shared.windows.first?.rootViewController = navigationController
            }

            it("pushes 'UserListViewController' onto stack") {
                expect(navigationController.viewControllers.last).toEventually(beAnInstanceOf(UserListViewController.self))
            }

            context("given 'showUser' is called") {
                beforeEach {
                    let user = ModelFactory.user
                    coordinator.showTODOs(user: user)
                }

                it("pushes 'TODOListViewController' onto stack") {
                    expect(navigationController.viewControllers.last).toEventually(beAnInstanceOf(TODOListViewController.self))
                }
            }
        }
    }
}
