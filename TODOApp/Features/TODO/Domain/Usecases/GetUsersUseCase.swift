//
//  GetUsersUseCase.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

class GetUsersUseCase {
    private let repository: UserRepository

    init(repository: UserRepository = UsersWebRepository()) {
        self.repository = repository
    }

    func fetchUsers() -> AnyPublisher<[User], NetworkError> {
        let users = repository.fetchUsers()
        return users
    }
}
