//
//  TODOWebRepositorySpec.swift
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

class TODOWebRepositorySpec: QuickSpec {
    override func spec() {
        describe("fetchTODO") {
            var cancellables: Set<AnyCancellable>!
            var repository: TODOWebRepository!

            beforeEach {
                cancellables = Set<AnyCancellable>()
            }

            context("given request is successful") {
                var subject: CurrentValueSubject<[TODO], NetworkError>!
                let todoResponse = ModelFactory.todoDTO

                beforeEach {
                    repository = TODOWebRepository(api: MOCKTODOAPI(response: [todoResponse]))
                    subject = CurrentValueSubject<[TODO], NetworkError>([])
                    repository.fetchTODO(id: 1).subscribe(subject).store(in: &cancellables)
                }

                it("retrives and maps the TODO response") {
                    expect(subject.value.count).to(equal(1))
                }

                it("returns todo with expected value") {
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
                    repository = TODOWebRepository(api: MOCKTODOAPI(success: false))
                    subject = CurrentValueSubject<[TODO], NetworkError>([])
                    repository.fetchTODO(id: 1).subscribe(subject).store(in: &cancellables)

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
