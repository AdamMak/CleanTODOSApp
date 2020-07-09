//
//  UserAPI.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

protocol UserFetchable {
    func fetchUsers() -> AnyPublisher<[UserDTO], NetworkError>
}

class UserAPI: UserFetchable {
    private let apiManager: NetworkService

    init(apiManager: NetworkService = APIManager()) {
        self.apiManager = apiManager
    }

    func fetchUsers() -> AnyPublisher<[UserDTO], NetworkError> {
        let request = UsersRequest()
        return apiManager.makeRequest(apiRequest: request).eraseToAnyPublisher()
    }
}
