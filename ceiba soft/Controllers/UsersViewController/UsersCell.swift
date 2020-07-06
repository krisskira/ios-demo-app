//
//  UsersCell.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 3/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import UIKit

class UsersCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPhone: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    static let CELL_ID = "UsersCell"
    
    fileprivate var user: UserModel! {
        willSet {
            userName.text = newValue.name
            userPhone.text = newValue.phone
            userEmail.text = newValue.email
        }
    }

    fileprivate var seePostAction: ( (_ user: UserModel )->Void ) = {_ in }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(user: UserModel, seePostAction: @escaping ( (_ user: UserModel)->Void ) ) {
        self.seePostAction = seePostAction
        self.user = user
    }
    
    @IBAction func seePost( sender: UIButton ){
        seePostAction(user)
    }

}
