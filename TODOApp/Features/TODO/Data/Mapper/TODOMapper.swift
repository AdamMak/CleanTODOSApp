//
//  TODOMapper.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

class TODOMapper: Mapper {
    func mapping(input: [TODODTO]) -> [TODO] {
        return input.map {
            TODO(userId: $0.userId,
                 id: $0.id,
                 title: $0.title,
                 completed: $0.completed)
        }
    }
}
