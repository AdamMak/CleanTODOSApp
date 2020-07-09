//
//  GetUsersUseCaseSpec.swift
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

class GetUsersUseCaseSpec: QuickSpec {
    override func spec() {
        describe("fetchUsers") {
            var cancellables: Set<AnyCancellable>!
            var usecase: GetUsersUseCase!

            beforeEach {
                cancellables = Set<AnyCancellable>()
            }

            context("given request is successful") {
                var subject: CurrentValueSubject<[User], NetworkError>!
                let userResponse = ModelFactory.user

                beforeEach {
                    subject = CurrentValueSubject<[User], NetworkError>([])
                    usecase = GetUsersUseCase(repository: MockUsersRepository(response: [userResponse]))
                    usecase.fetchUsers().subscribe(subject).store(in: &cancellables)
                }

                it("returns expected number of users") {
                    expect(subject.value.count).to(equal(1))
                }

                it("returns user with expected value") {
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
                    subject = CurrentValueSubject<[User], NetworkError>([])
                    usecase = GetUsersUseCase(repository: MockUsersRepository(success: false))
                    usecase.fetchUsers().subscribe(subject).store(in: &cancellables)

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
