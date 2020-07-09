//
//  UsersRequest.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

class UsersRequest: APIRequest {
    let method: HTTPMethod = .get
    let url: URL
    let parameters: [String: String] = [:]

    init() {
        self.url = URL(string: RequestURLs.usersURL)!
    }
}
