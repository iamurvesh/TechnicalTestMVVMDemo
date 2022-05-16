//
//  FavouriteViewModel.swift
//  Technical Test
//
//  Created by Urvesh on 13/05/22.
//

import UIKit

class FavouriteViewModel {

    var viewController : FavouriteVC?
    var arrAllPosts = [ModelPost]()
    var arrPosts = [ModelPost]()
    
    func getAllFavouritePost() {
        
        self.arrAllPosts.removeAll()
        UserDefaults.serverPots.forEach { post in
            if UserDefaults.favouritePostsId.contains(post.id) {
                self.arrAllPosts.append(post)
            }
        }
        self.arrPosts = self.arrAllPosts
        self.reloadTable()
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
    
    func removeFromFavourite(index: Int)  {
        if UserDefaults.favouritePostsId.contains(self.arrPosts[index].id) {
            UserDefaults.favouritePostsId = UserDefaults.favouritePostsId.filter{$0 != self.arrPosts[index].id}
            self.arrAllPosts = self.arrAllPosts.filter{$0.id != self.arrPosts[index].id}
            self.arrPosts = self.arrPosts.filter{$0.id != self.arrPosts[index].id}
        }
        self.reloadTable()
    }
    
    func reloadTable() {
        self.viewController?.tblView.reloadData()
        if self.arrPosts.count == 0 {
            self.viewController?.tblView.EmptyMessage(message: "No data found!")
        }
        else {
            self.viewController?.tblView.EmptyMessage(message: "")
        }
    }
}
