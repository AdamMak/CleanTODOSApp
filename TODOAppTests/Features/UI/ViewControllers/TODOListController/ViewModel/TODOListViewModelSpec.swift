//
//  TODOListViewModelSpec.swift
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

class TODOListViewModelSpec: QuickSpec {
    override func spec() {
        describe("fetchTODOs") {
            var viewModel: TODOListViewModel!
            
            context("given request is successful") {
                beforeEach {
                    let user = ModelFactory.user
                    let usecase = GetTODOUseCase(repository: MockTODORepository(success: true))
                    viewModel = TODOListViewModel(coordinator: nil,
                                                  usecase: usecase,
                                                  user: user)
                    viewModel.fetchTODOs()
                }

                it("returns expected number of cell view models") {
                    expect(viewModel.cellViewModels.count).to(equal(1))
                }
            }

            context("given request fails") {
                beforeEach {
                    let user = ModelFactory.user
                    let usecase = GetTODOUseCase(repository: MockTODORepository(success: false))
                    viewModel = TODOListViewModel(coordinator: nil,
                                                  usecase: usecase,
                                                  user: user)
                    viewModel.fetchTODOs()
                }

                it("returns expected number of cell view models") {
                    expect(viewModel.cellViewModels.count).to(equal(0))
                }
            }
        }
    }
}
