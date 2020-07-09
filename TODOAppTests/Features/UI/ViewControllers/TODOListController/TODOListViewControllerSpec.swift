//
//  TODOListViewControllerSpec.swift
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

class TODOListViewControllerSpec: QuickSpec {
    override func spec() {
        describe("onLoad") {
            var viewController: TODOListViewController!

            context("given request is successful") {
                beforeEach {
                    let usecase = GetTODOUseCase(repository: MockTODORepository(success: true))
                    let user = ModelFactory.user
                    let viewModel = TODOListViewModel(coordinator: nil,
                                                      usecase: usecase,
                                                      user: user)
                    viewController = TODOListViewController(viewModel: viewModel)
                    UIApplication.shared.windows.first?.rootViewController = viewController
                }

                it("returns expected number of table cells") {
                    expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(1))
                }
            }

            context("given request fails") {
                beforeEach {
                    let usecase = GetTODOUseCase(repository: MockTODORepository(success: false))
                    let user = ModelFactory.user
                    let viewModel = TODOListViewModel(coordinator: nil,
                                                      usecase: usecase,
                                                      user: user)
                    viewController = TODOListViewController(viewModel: viewModel)
                    UIApplication.shared.windows.first?.rootViewController = viewController
                }

                it("returns expected number of table cells") {
                    expect(viewController.tableView.numberOfRows(inSection: 0)).toEventually(equal(0))
                }
            }

            context("given request fails") {
                beforeEach {
                    let usecase = GetTODOUseCase(repository: MockTODORepository(success: false))
                    let user = ModelFactory.user
                    let viewModel = TODOListViewModel(coordinator: nil,
                                                      usecase: usecase,
                                                      user: user)
                    viewController = TODOListViewController(viewModel: viewModel)
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
                    expect(alertController?.message).toEventually(equal("Error Fetching TODOs"))
                    expect(alertController?.actions[0].title).toEventually(equal("Try Again"))
                }
            }
        }
    }
}

