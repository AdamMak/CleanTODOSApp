//
//  TODORequest.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation

class TODORequest: APIRequest {
    let method: HTTPMethod = .get
    let url: URL
    var parameters: [String: String] = [:]

    init(id: Int) {
        parameters["userId"] = "\(id)"
        
        self.url = URL(string: RequestURLs.todosURL)!
    }
}
