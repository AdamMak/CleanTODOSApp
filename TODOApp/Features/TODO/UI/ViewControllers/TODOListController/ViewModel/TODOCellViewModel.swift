//
//  TODOCellViewModel.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

class TODOCellViewModel {
    let title: String
    let completed: String

    init(todo: TODO) {
        self.title = todo.title
        let string = todo.completed ? "Complete" : "TODO"
        self.completed = string
    }
}

// MARK: Hashable

extension TODOCellViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

    static func == (lhs: TODOCellViewModel, rhs: TODOCellViewModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.completed == rhs.completed
    }
}

