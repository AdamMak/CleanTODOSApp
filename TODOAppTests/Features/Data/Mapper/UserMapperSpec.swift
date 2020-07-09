//
//  UserMapperSpec.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import TODOApp

class UserMapperSpec: QuickSpec {
    override func spec() {
        describe("mapping") {
            context("given an array of user DTOs") {
                var mapper: UsersMapper!
                var result: [User]!
                let userDTO = ModelFactory.userDTO

                beforeEach {
                    mapper = UsersMapper()
                    result = mapper.mapping(input: [userDTO])
                }

                it("returns expected number of users") {
                    expect(result.count).to(equal(1))
                }

                it("maps values correctly") {
                    let user = result[0]
                    expect(user.id).to(equal(userDTO.id))
                    expect(user.name).to(equal(userDTO.name))
                    expect(user.email).to(equal(userDTO.email))
                }
            }
        }
    }
}
