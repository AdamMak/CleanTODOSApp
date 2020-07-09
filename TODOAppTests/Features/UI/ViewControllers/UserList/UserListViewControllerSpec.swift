//
//  UserListViewControllerSpec.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit
import Quick
import Nimble
import Combine

@testable import TODOApp

class UserListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("onLoad") {
            context("given fetch request is successful") {
                var viewController: UserListViewController!
                var spy: SpyUserListCoordinator!

                beforeEach {
                    spy = SpyUserListCoordinator(presenter: nil)
                    let usecase = GetUsersUseCase(repository: MockUsersRepository(success: true))
                    let viewModel = UserListViewModel(coordinator: spy,
                                                  usecase: usecase)
                    viewController = UserListViewController(viewModel: viewModel)
                    UIApplication.shared.windows.first?.rootViewController = viewController
                }

                it("sets up table view with expected number of cells") {
                    expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(1))
                }

                context("given a cell is tapped") {
                    beforeEach {
                        let tableView = viewController.tableView!
                        viewController.tableView.delegate?.tableView?(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    }

                    it("sends message to delegate") {
                        expect(spy.didTapShowUser).toEventually(beTrue())
                    }
                }
            }

            context("given fetch request fails") {
                var viewController: UserListViewController!

                beforeEach {
                    let usecase = GetUsersUseCase(repository: MockUsersRepository(success: false))
                    let viewModel = UserListViewModel(coordinator: nil,
                                                  usecase: usecase)
                    viewController = UserListViewController(viewModel: viewModel)
                    UIApplication.shared.windows.first?.rootViewController = viewController
                }

                it("shows empty tableView") {
                    expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(0))
                }

                it("shows alert view controller") {
                    let rootViewController = UIApplication.shared.windows.first?.rootViewController
                    expect(rootViewController?.presentedViewController).toEventually(beAnInstanceOf(UIAlertController.self))

                    let alertController = rootViewController?.presentedViewController as? UIAlertController
                    expect(alertController?.title).toEventually(equal("Error"))
                    expect(alertController?.message).toEventually(equal("Error Fetching Users"))
                    expect(alertController?.actions[0].title).toEventually(equal("Try Again"))
                }
            }
        }
    }
}
