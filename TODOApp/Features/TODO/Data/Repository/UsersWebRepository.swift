//
//  UsersWebRepository.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

class UsersWebRepository: UserRepository {
    private let api: UserFetchable
    
    init(api: UserFetchable = UserAPI()) {
        self.api = api
    }

    func fetchUsers() -> AnyPublisher<[User], NetworkError> {
        let mapper = UsersMapper()
        return api.fetchUsers().mapErase {
            mapper.mapping(input: $0)
        }
    }
}
