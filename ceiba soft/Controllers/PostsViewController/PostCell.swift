//
//  PostCell.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 5/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    static let CELL_ID: String = "PostCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(post: PostsModel){
        titleLabel.text = post.title
        messageLabel.text = post.body
    }

}
