//
//  ModelFactory.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

@testable import TODOApp

struct ModelFactory {
    static var todoIncomplete: TODO {
        return TODO(userId: 1, id: 1, title: "TODO", completed: false)
    }

    static var todoComplete: TODO {
        return TODO(userId: 1, id: 1, title: "TODO", completed: true)
    }

    static var todoDTO: TODODTO {
        return TODODTO(userId: 1, id: 1, title: "TODO", completed: false)
    }

    static var user: User {
        return User(id: 1, name: "John", email: "john@gmail.com")
    }

    static var userDTO: UserDTO {
        return UserDTO(id: 1, name: "John", email: "john@gmail.com")
    }
}
