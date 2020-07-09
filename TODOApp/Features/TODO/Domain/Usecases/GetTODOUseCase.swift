//
//  GetTODOUseCase.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

class GetTODOUseCase {
    private let repository: TODORepository

    init(repository: TODORepository = TODOWebRepository()) {
        self.repository = repository
    }

    func fetchTODOs(id: Int) -> AnyPublisher<[TODO], NetworkError> {
        let todos = repository.fetchTODO(id: id)
        return todos
    }
}
