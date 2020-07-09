//  
//  UserListViewModel.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import Foundation
import Combine

final class UserListViewModel: MappableViewModel {
    typealias CustomError = NetworkError

    private let coordinator:UserListCoordinator?
    private let usecase: GetUsersUseCase
    var cancellables = Set<AnyCancellable>()
    private var users: [User] = []
    @Published private(set) var cellViewModels: [UserCellViewModel] = []
    @Published private(set) var error: Error?

    init(coordinator: UserListCoordinator?,
         usecase: GetUsersUseCase) {
        self.coordinator = coordinator
        self.usecase = usecase
    }

    func fetchUsers() {
        let results = usecase.fetchUsers()
        let users = createPropertyPublisher(publisher: results)

        results.handleError(errorCompletion: { error in
            print(error)
            self.error = error
        }).store(in: &cancellables)

        let cellViewModels = users.map { users in
            users.map { UserCellViewModel(user: $0) }
            }.eraseToAnyPublisher()

        bind(users, to: \.users)
        bind(cellViewModels, to: \.cellViewModels)
    }

    func didSelect(index: Int) {
        let user = users[index]
        coordinator?.showTODOs(user: user)
    }
}
