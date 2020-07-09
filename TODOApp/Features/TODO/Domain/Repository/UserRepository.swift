//
//  UserRepository.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

protocol UserRepository {
    func fetchUsers() -> AnyPublisher<[User], NetworkError>
}
