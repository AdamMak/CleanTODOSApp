//
//  UserCellViewModel.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

class UserCellViewModel {
    let name: String
    let email: String

    init(user: User) {
        name = user.name
        email = user.email
    }
}

// MARK: Hashable & Equatable

extension UserCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    // MARK: Equatable

    static func == (lhs: UserCellViewModel, rhs: UserCellViewModel) -> Bool {
        return lhs.name == rhs.name &&
            lhs.email == rhs.email
    }
}
