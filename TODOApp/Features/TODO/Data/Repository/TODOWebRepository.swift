//
//  TODOWebRepository.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

class TODOWebRepository: TODORepository {
    private let api: TODOFetchable

    init(api: TODOFetchable = TODOAPI()) {
        self.api = api
    }

    func fetchTODO(id: Int) -> AnyPublisher<[TODO], NetworkError> {
        let mapper = TODOMapper()
        return api.fetchTODO(id: id).mapErase {
            mapper.mapping(input: $0)
        }
    }
}
