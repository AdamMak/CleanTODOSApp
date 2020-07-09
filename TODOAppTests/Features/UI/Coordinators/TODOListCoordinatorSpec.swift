//
//  TODOListCoordinatorSpec.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import TODOApp

class TODOListCoordinatorSpec: QuickSpec {
    override func spec() {
        describe("start") {
            var coordinator: TODOListCoordinator!
            var navigationController: UINavigationController!

            beforeEach {
                navigationController = UINavigationController()
                let user = ModelFactory.user
                coordinator = TODOListCoordinator(presenter: navigationController, user: user)
                coordinator.start()
                UIApplication.shared.windows.first?.rootViewController = navigationController
            }

            it("pushes 'TODOListViewController' onto stack") {
                expect(navigationController.viewControllers.last).toEventually(beAnInstanceOf(TODOListViewController.self))
            }
        }
    }
}
