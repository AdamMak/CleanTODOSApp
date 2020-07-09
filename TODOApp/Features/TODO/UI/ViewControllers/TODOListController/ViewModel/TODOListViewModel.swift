//  
//  TODOListViewModel.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Combine

final class TODOListViewModel: MappableViewModel {
    typealias CustomError = NetworkError

    private let coordinator:TODOListCoordinator?
    private let usecase: GetTODOUseCase
    var cancellables = Set<AnyCancellable>()
    private var todos: [TODO] = []
    private let user: User
    @Published private(set) var cellViewModels: [TODOCellViewModel] = []
    @Published private(set) var error: Error?

    init(coordinator: TODOListCoordinator?,
         usecase: GetTODOUseCase,
         user: User) {
        self.coordinator = coordinator
        self.usecase = usecase
        self.user = user
    }

    func fetchTODOs() {
        let results = usecase.fetchTODOs(id: user.id)
        let todos = createPropertyPublisher(publisher: results)

        results.handleError(errorCompletion: { error in
            print(error)
            self.error = error
        }).store(in: &cancellables)

        let cellViewModels = todos.mapErase { todos in
            todos.map { TODOCellViewModel(todo: $0)}
        }

        bind(todos, to: \.todos)
        bind(cellViewModels, to: \.cellViewModels)
    }
}
