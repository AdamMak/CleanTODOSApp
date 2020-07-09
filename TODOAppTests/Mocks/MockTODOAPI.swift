//
//  MockTODOAPI.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine
@testable import TODOApp

class MOCKTODOAPI: TODOFetchable {
    private let mockSuccess: Bool
    private let response: [TODODTO]

    init(success: Bool) {
        self.mockSuccess = success
        self.response = [ModelFactory.todoDTO]
    }

    init(response: [TODODTO]) {
        self.mockSuccess = true
        self.response = response
    }

    func fetchTODO(id: Int) -> AnyPublisher<[TODODTO], NetworkError> {
        if mockSuccess {
            return Result<[TODODTO], NetworkError>
                .Publisher(.success(response))
                .eraseToAnyPublisher()
        } else {
            return Result<[TODODTO], NetworkError>
                .Publisher(.failure(NetworkError.dataNotExtracted))
                .eraseToAnyPublisher()
        }
    }
}
