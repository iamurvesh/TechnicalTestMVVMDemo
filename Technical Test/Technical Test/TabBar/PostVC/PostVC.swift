//
//  PostVC.swift
//  Technical Test
//
//  Created by Urvesh on 13/05/22.
//

import UIKit

class PostVC: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var tblView: UITableView!
    @IBOutlet var vwSearchBar: UISearchBar!
    
    var viewModel = PostViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getAllPost()
    }

}
//MARK: - Init Config Method
extension PostVC {
    
    private func initConfig() {
        self.viewModel.viewController = self
        self.vwSearchBar.delegate = self
        self.tblView.registerCell(withNib: "PostTCell")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.tableHeaderView = self.vwSearchBar
    }
    
}

//MARK: - UISearchBar Delegate Method
extension PostVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchPost(strSearch: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

//MARK: - UiTablview Delegate Method
extension PostVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.arrPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTCell", for: indexPath) as? PostTCell else { return UITableViewCell() }
        
        cell.dataBind(obj: self.viewModel.arrPosts[indexPath.row])
        cell.favouriteTap = {
            self.viewModel.removeFavourite(index: indexPath.row)
        }
        return cell
    }
}
