//
//  TODOCellViewModelSpec.swift
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

class TODOCellViewModelSpec: QuickSpec {
    override func spec() {
        describe("title") {
            var viewModel: TODOCellViewModel!
            let todo = ModelFactory.todoComplete

            beforeEach {
                viewModel = TODOCellViewModel(todo: todo)
            }

            it("returns expected title") {
                expect(viewModel.title).to(equal(todo.title))
            }
        }

        describe("completed") {
            var viewModel: TODOCellViewModel!

            context("given todo is complete") {
                beforeEach {
                    let todo = ModelFactory.todoComplete
                    viewModel = TODOCellViewModel(todo: todo)
                }

                it("returns 'Complete'") {
                    expect(viewModel.completed).to(equal("Complete"))
                }
            }

            context("given todo is not complete") {
                beforeEach {
                    let todo = ModelFactory.todoIncomplete
                    viewModel = TODOCellViewModel(todo: todo)
                }

                it("returns 'TODO'") {
                    expect(viewModel.completed).to(equal("TODO"))
                }
            }
        }
    }
}
