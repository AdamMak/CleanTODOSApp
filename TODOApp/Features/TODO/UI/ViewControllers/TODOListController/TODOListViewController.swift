//  
//  TODOListViewController.swift
//  TODOApp
//
//  Created by Adam Makhfoudi on 08/07/2020.
//  Copyright © 2020 Adam Makhfoudi. All rights reserved.
//

import UIKit
import Combine

class TODOListViewController: UIViewController {
    @IBOutlet private(set) weak var tableView: UITableView!
    
    private let viewModel: TODOListViewModel
    private lazy var dataSource = makeDataSource()
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: TODOListViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TODO List"

        viewModel.fetchTODOs()

        setUpTableView()

        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.$cellViewModels.receive(on: DispatchQueue.main).sink(receiveValue: { [weak self] cellViewModels in
            var snapshot = NSDiffableDataSourceSnapshot<TODOTableViewCell, TODOCellViewModel>()
            snapshot.appendSections([TODOTableViewCell()])
            snapshot.appendItems(cellViewModels)
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
        showAlertController(title: "Error", message: "Error Fetching TODOs", actionText: "Try Again", action: { [weak self] in
            self?.viewModel.fetchTODOs()
        })
    }

    private func setUpTableView() {
        tableView.registerCustomCell(cell: TODOTableViewCell.self)
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
    }

    private func makeDataSource() -> UITableViewDiffableDataSource<TODOTableViewCell, TODOCellViewModel> {
        return UITableViewDiffableDataSource<TODOTableViewCell, TODOCellViewModel>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, cellViewModel -> TODOTableViewCell? in
                let cell = tableView.dequeueReusableCell(withIdentifier: TODOTableViewCell.identifier, for: indexPath) as? TODOTableViewCell
                cell?.configure(with: cellViewModel)
                return cell
        })
    }
}
