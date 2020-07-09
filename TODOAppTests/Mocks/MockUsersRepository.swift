//
//  MockUsersRepository.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine
@testable import TODOApp

class MockUsersRepository: UserRepository {
    private let mockSuccess: Bool
    private let response: [User]

    init(success: Bool) {
        self.mockSuccess = success
        self.response = [ModelFactory.user]
    }

    init(response: [User]) {
        self.mockSuccess = true
        self.response = response
    }

    func fetchUsers() -> AnyPublisher<[User], NetworkError> {
        if mockSuccess {
            return Result<[User], NetworkError>
                .Publisher(.success(response))
                .eraseToAnyPublisher()
        } else {
            return Result<[User], NetworkError>
                .Publisher(.failure(NetworkError.dataNotExtracted))
                .eraseToAnyPublisher()
        }
    }
}
