//
//  MockUserAPI.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine
@testable import TODOApp

class MOCKUserAPI: UserFetchable {
    private let mockSuccess: Bool
    private let response: [UserDTO]

    init(success: Bool) {
        self.mockSuccess = success
        self.response = [ModelFactory.userDTO]
    }

    init(response: [UserDTO]) {
        self.mockSuccess = true
        self.response = response
    }

    func fetchUsers() -> AnyPublisher<[UserDTO], NetworkError> {
        if mockSuccess {
            return Result<[UserDTO], NetworkError>
                .Publisher(.success(response))
                .eraseToAnyPublisher()
        } else {
            return Result<[UserDTO], NetworkError>
                .Publisher(.failure(NetworkError.dataNotExtracted))
                .eraseToAnyPublisher()
        }
    }
}
