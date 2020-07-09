//
//  UserCellViewModelSpec.swift
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

class UserCellViewModelSpec: QuickSpec {
    override func spec() {
        var viewModel: UserCellViewModel!
        let user = ModelFactory.user

        beforeEach {
            viewModel = UserCellViewModel(user: user)
        }

        describe("name") {
            it("returns expected name") {
                expect(viewModel.name).to(equal(user.name))
            }
        }

        describe("email") {
            it("returns expected email") {
                expect(viewModel.email).to(equal(user.email))
            }
        }
    }
}
