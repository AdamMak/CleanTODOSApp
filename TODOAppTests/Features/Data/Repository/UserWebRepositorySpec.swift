//
//  UserWebRepositorySpec.swift
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

class UserWebRepositorySpec: QuickSpec {
    override func spec() {
        describe("fetchUsers") {
            var cancellables: Set<AnyCancellable>!
            var repository: UsersWebRepository!

            beforeEach {
                cancellables = Set<AnyCancellable>()
            }

            context("given request is successful") {
                var subject: CurrentValueSubject<[User], NetworkError>!
                let userResponse = ModelFactory.userDTO

                beforeEach {
                    repository = UsersWebRepository(api: MOCKUserAPI(response: [userResponse]))
                    subject = CurrentValueSubject<[User], NetworkError>([])
                    repository.fetchUsers().subscribe(subject).store(in: &cancellables)
                }

                it("retrives the expected number of users") {
                    expect(subject.value.count).to(equal(1))
                }

                it("returns userTDO with expected value") {
                    let user = subject.value[0]
                    expect(user.id).to(equal(userResponse.id))
                    expect(user.name).to(equal(userResponse.name))
                    expect(user.email).to(equal(userResponse.email))
                }
            }

            context("given request fails") {
                var subject: CurrentValueSubject<[User], NetworkError>!
                var returnedError: NetworkError?

                beforeEach {
                    repository = UsersWebRepository(api: MOCKUserAPI(success: false))
                    subject = CurrentValueSubject<[User], NetworkError>([])
                    repository.fetchUsers().subscribe(subject).store(in: &cancellables)

                    subject.error(errorCompletion: { error in
                        returnedError = error as? NetworkError
                    }).store(in: &cancellables)
                }

                it("returns an error") {
                    expect(returnedError).toEventuallyNot(beNil())
                }
            }
        }
    }
}
