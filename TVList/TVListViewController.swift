//
//  TVListViewController.swift
//  TVList
//
//  Created by SashaShch on 04.01.2021.
//

import UIKit

class TVListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: TVListViewModel!

    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        
        viewModel = TVListViewModel()
        viewModel.delegate = self
        
        viewModel.loadProgramms()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        if let id = viewModel.programmList.items.first?.id {
            viewModel.loadProgramms(borderId: id, direction: "-1")
        }
    }
}

extension TVListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.programmList.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TVListCell
        cell = tableView.dequeueReusableCell(withIdentifier: "TVListCell", for: indexPath) as! TVListCell
        
        cell.programmTitle.text = viewModel.programmList.items[indexPath.item].name
        if let url = URL(string: viewModel.programmList.items[indexPath.item].icon) {
            if let data = try? Data(contentsOf: url) {
                cell.programmIcon.image = UIImage(data: data)
            }
        }
        let offset = viewModel.programmList.items.count
        let id = viewModel.programmList.items[indexPath.item].id
        let lastElement = offset - 1
        if indexPath.row == lastElement {
            viewModel.loadProgramms(borderId: id, direction: "1")
        }
        
        
        return cell
    }
}

extension TVListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension TVListViewController: TVListViewModelDelegate {
    
    func didStartFetching() {
        activityIndicator.isHidden = false
    }
    
    func didFinishFetcing() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}
