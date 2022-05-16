//
//  PostTCell.swift
//  Technical Test
//
//  Created by Urvesh on 13/05/22.
//

import UIKit

class PostTCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblBody: UILabel!
    @IBOutlet var btnFavourite: UIButton!
    
    var favouriteTap : (() -> Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func dataBind(obj: ModelPost) {
        self.lblTitle.text = obj.title
        self.lblBody.text = obj.body
        if UserDefaults.favouritePostsId.contains(obj.id) {
            self.btnFavourite.setImage(UIImage(systemName: "book.fill"), for: .normal)
        } else {
            self.btnFavourite.setImage(UIImage(systemName: "book"), for: .normal)
        }
    }
    
    @IBAction func btnFavourite(_ sender: Any) {
        if let function = self.favouriteTap{
            function()
        }
    }
}
