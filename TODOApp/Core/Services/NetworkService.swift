//
//  NetworkService.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 07/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

protocol NetworkService {
    func makeRequest<ResponseType: APIResponse>(apiRequest: APIRequest) -> AnyPublisher<ResponseType, NetworkError>
}
