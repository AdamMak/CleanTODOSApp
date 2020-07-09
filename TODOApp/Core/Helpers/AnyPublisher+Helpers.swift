//
//  AnyPublisher+Helpers.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

extension AnyPublisher {
  // this is just so you don't have to call `eraseToAnyPublisher` after every map...
    public func mapErase<T>(_ transform: @escaping (Self.Output) -> T) -> AnyPublisher<T, Failure> {
        return map(transform).eraseToAnyPublisher()
    }

    func handleError(errorCompletion: @escaping (Error) -> ()) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorCompletion(error)
            }
        }, receiveValue: { val in })
    }
}
