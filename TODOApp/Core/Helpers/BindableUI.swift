//
//  BindableUI.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 07/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit
import Combine

protocol BindableUI: class {
    var cancellables: Set<AnyCancellable> { get set }

    func bind<Object, Value>(_ publisher: Published<Value>.Publisher,
                             to keyPath: ReferenceWritableKeyPath<Object, Value>,
                             on object: Object)

    func bindViewModel()
}

extension BindableUI {
    func bind<Object, Value>(_ publisher: Published<Value>.Publisher,
                             to keyPath: ReferenceWritableKeyPath<Object, Value>,
                             on object: Object) {
        publisher
            .receive(on: DispatchQueue.main)
            .assign(to: keyPath, on: object)
            .store(in: &cancellables)
    }
}
