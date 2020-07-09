//
//  GetTODOUseCaseSpec.swift
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

class GetTODOUseCaseSpec: QuickSpec {
    override func spec() {
        describe("fetchUsers") {
            var cancellables: Set<AnyCancellable>!
            var usecase: GetTODOUseCase!

            beforeEach {
                cancellables = Set<AnyCancellable>()
            }

            context("given request is successful") {
                var subject: CurrentValueSubject<[TODO], NetworkError>!
                let todoResponse = ModelFactory.todoComplete

                beforeEach {
                    subject = CurrentValueSubject<[TODO], NetworkError>([])
                    usecase = GetTODOUseCase(repository: MockTODORepository(response: [todoResponse]))
                    usecase.fetchTODOs(id: 1).subscribe(subject).store(in: &cancellables)
                }

                it("returns expected number of todos") {
                    expect(subject.value.count).to(equal(1))
                }

                it("returns user with expected value") {
                    let todo = subject.value[0]
                    expect(todo.id).to(equal(todoResponse.id))
                    expect(todo.userId).to(equal(todoResponse.userId))
                    expect(todo.title).to(equal(todoResponse.title))
                    expect(todo.completed).to(equal(todoResponse.completed))
                }
            }

            context("given request fails") {
                var subject: CurrentValueSubject<[TODO], NetworkError>!
                var returnedError: NetworkError?

                beforeEach {
                    subject = CurrentValueSubject<[TODO], NetworkError>([])
                    usecase = GetTODOUseCase(repository: MockTODORepository(success: false))
                    usecase.fetchTODOs(id: 1).subscribe(subject).store(in: &cancellables)

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
