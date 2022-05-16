//
//  PostViewModel.swift
//  Technical Test
//
//  Created by Urvesh on 13/05/22.
//

import UIKit

class PostViewModel {
    
    var viewController : PostVC?
    var arrAllPosts = [ModelPost]()
    var arrPosts = [ModelPost]()
    

    func getAllPost() {
        
        APIManager.makeRequest(with: AppConstant.API.kPosts, method: .get, parameter: [:]) {(response) in
            
            if let arrData = response as? [[String:Any]] {
                self.arrAllPosts = arrData.compactMap(ModelPost.init)
                self.arrPosts = self.arrAllPosts
                self.reloadTable()
            }
            
        } failure: { (error) in
            self.arrAllPosts.removeAll()
            self.arrPosts.removeAll()
            self.reloadTable()
            
        } connectionFailed: { (connectionError) in
            if UserDefaults.serverPots.count == 0 {
                self.viewController?.showAlert(with: connectionError)
            }
            else {
                self.arrAllPosts = UserDefaults.serverPots
                self.arrPosts = self.arrAllPosts
                self.reloadTable()
            }
        }
    }
    
    func searchPost(strSearch: String) {
        if strSearch == "" {
            self.arrPosts = self.arrAllPosts
        }
        else {
            self.arrPosts = self.arrAllPosts.filter{$0.title.localizedCaseInsensitiveContains(strSearch)}
        }
        self.reloadTable()
    }
    
    func reloadTable() {
        UserDefaults.serverPots = self.arrAllPosts
        self.viewController?.tblView.reloadData()
        if self.arrPosts.count == 0 {
            self.viewController?.tblView.EmptyMessage(message: "No data found!")
        }
        else {
            self.viewController?.tblView.EmptyMessage(message: "")
        }
    }
    
    func removeFavourite(index: Int)  {
        if UserDefaults.favouritePostsId.contains(self.arrPosts[index].id) {
            UserDefaults.favouritePostsId = UserDefaults.favouritePostsId.filter{$0 != self.arrPosts[index].id}
        }
        else {
            let tempArray : [Int] = UserDefaults.favouritePostsId
            UserDefaults.favouritePostsId = tempArray + [self.arrPosts[index].id]
        }
        self.reloadTable()
    }
}
