//
//  MockTODORepository.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine
@testable import TODOApp

class MockTODORepository: TODORepository {
    private let mockSuccess: Bool
    private let response: [TODO]

    init(success: Bool) {
        self.mockSuccess = success
        self.response = [ModelFactory.todoComplete]
    }

    init(response: [TODO]) {
        self.mockSuccess = true
        self.response = response
    }

    func fetchTODO(id: Int) -> AnyPublisher<[TODO], NetworkError> {
        if mockSuccess {
            return Result<[TODO], NetworkError>
                .Publisher(.success(response))
                .eraseToAnyPublisher()
        } else {
            return Result<[TODO], NetworkError>
                .Publisher(.failure(NetworkError.dataNotExtracted))
                .eraseToAnyPublisher()
        }
    }
}

