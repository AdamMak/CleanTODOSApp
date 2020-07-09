//
//  UserListViewModelSpec.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Combine

@testable import TODOApp

class SpyUserListCoordinator: UserListCoordinator {
    private(set) var didTapShowUser = false

    override func showTODOs(user: User) {
         didTapShowUser = true
    }
}

class UserListViewModelSpec: QuickSpec {
    override func spec() {
        describe("fetchUsers") {
            var viewModel: UserListViewModel!

            context("given request is successful") {
                beforeEach {
                    let usecase = GetUsersUseCase(repository: MockUsersRepository(success: true))
                    viewModel = UserListViewModel(coordinator: nil,
                                                  usecase: usecase)
                    viewModel.fetchUsers()
                }

                it("creates expected number of cellViewModels") {
                    expect(viewModel.cellViewModels.count).toEventually(equal(1))
                }

                it("returns no error") {
                    expect(viewModel.error).to(beNil())
                }
            }

            context("given request fails") {
                beforeEach {
                    let usecase = GetUsersUseCase(repository: MockUsersRepository(success: false))
                    viewModel = UserListViewModel(coordinator: nil,
                                                  usecase: usecase)
                    viewModel.fetchUsers()
                }

                it("returns 0 cellViewModels") {
                    expect(viewModel.cellViewModels.count).toEventually(equal(0))
                }

                it("returns an error") {
                    expect(viewModel.error).toNot(beNil())
                }
            }
        }

        describe("didSelect") {
            var viewModel: UserListViewModel!
            var spy: SpyUserListCoordinator!

            beforeEach {
                spy = SpyUserListCoordinator(presenter: nil)
                let usecase = GetUsersUseCase(repository: MockUsersRepository(success: true))
                viewModel = UserListViewModel(coordinator: spy,
                                              usecase: usecase)
                viewModel.fetchUsers()
                viewModel.didSelect(index: 0)
            }

            it("sends message 'showUser' to coordinator") {
                expect(spy.didTapShowUser).toEventually(beTrue())
            }
        }
    }
}
