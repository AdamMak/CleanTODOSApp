//
//  CurrentValueSubject+Helpers.swift
//  TODOAppTests
//
//  Created by Adam Makhfoudi on 09/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine

extension CurrentValueSubject {
    func error(errorCompletion: @escaping (Error) -> ()) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorCompletion(error)
            }
        }, receiveValue: { val in })
    }
}
