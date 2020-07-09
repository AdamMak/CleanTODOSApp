//
//  TODOMapperSpec.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import TODOApp

class TODOMapperSpec: QuickSpec {
    override func spec() {
        describe("mapping") {
            context("given an array of todo DTOs") {
                var mapper: TODOMapper!
                var result: [TODO]!
                let todoDTO = ModelFactory.todoDTO

                beforeEach {
                    mapper = TODOMapper()
                    result = mapper.mapping(input: [todoDTO])
                }

                it("returns expected number of todos") {
                    expect(result.count).to(equal(1))
                }

                it("maps values correctly") {
                    let todo = result[0]
                    expect(todo.id).to(equal(todo.id))
                    expect(todo.userId).to(equal(todo.userId))
                    expect(todo.title).to(equal(todo.title))
                    expect(todo.completed).to(equal(todo.completed))
                }
            }
        }
    }
}
