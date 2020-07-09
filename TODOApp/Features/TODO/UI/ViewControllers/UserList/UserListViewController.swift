//  
//  UserListViewController.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit
import Combine

class UserListViewController: UIViewController {
    @IBOutlet private(set) weak var tableView: UITableView!
    
    private let viewModel: UserListViewModel
    private lazy var dataSource = makeDataSource()
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Users"

        viewModel.fetchUsers()

        setUpTableView()

        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.$cellViewModels
        .receive(on: DispatchQueue.main)
        .sink(receiveValue: { [weak self] cellViewModel in
            var snapshot = NSDiffableDataSourceSnapshot<UserTableViewCell, UserCellViewModel>()
            snapshot.appendSections([UserTableViewCell()])
            snapshot.appendItems(cellViewModel)
            self?.dataSource.apply(snapshot, animatingDifferences: false)
        }).store(in: &cancellables)

        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] error in
                guard error != nil else {
                    return
                }

                self?.showErrorAlert()
            }).store(in: &cancellables)
    }

    private func showErrorAlert() {
        showAlertController(title: "Error",
                            message: "Error Fetching Users",
                            actionText: "Try Again",
                            action: { [weak self] in
            self?.viewModel.fetchUsers()
        })
    }

    private func setUpTableView() {
        tableView.registerCustomCell(cell: UserTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

    private func makeDataSource() -> UITableViewDiffableDataSource<UserTableViewCell, UserCellViewModel> {
        return UITableViewDiffableDataSource<UserTableViewCell, UserCellViewModel>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, cellViewModel -> UserTableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell
                cell?.configure(with: cellViewModel)
                return cell
        })
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(index: indexPath.row)
    }
}
