//
//  TODO.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

struct TODO: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
