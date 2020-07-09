//
//  TODOAPI.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

protocol TODOFetchable {
    func fetchTODO(id: Int) -> AnyPublisher<[TODODTO], NetworkError>
}

class TODOAPI: TODOFetchable {
    private let apiManager: NetworkService

    init(apiManager: NetworkService = APIManager()) {
        self.apiManager = apiManager
    }

    func fetchTODO(id: Int) -> AnyPublisher<[TODODTO], NetworkError> {
        let request = TODORequest(id: id)
        return apiManager.makeRequest(apiRequest: request).eraseToAnyPublisher()
    }
}
