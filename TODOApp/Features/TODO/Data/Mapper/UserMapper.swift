//
//  UserMapper.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

class UsersMapper: Mapper {
    func mapping(input: [UserDTO]) -> [User] {
        return input.map {
            User(id: $0.id,
                 name: $0.name,
                 email: $0.email)
        }
    }
}
