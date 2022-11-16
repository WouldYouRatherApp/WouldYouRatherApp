//
//  ProfileTableViewCell.swift
//  wouldyourather
//
//  Created by Francisco Lira on 11/14/22.
//

import UIKit
import Parse

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var profileUsername: UILabel!
    
    @IBOutlet weak var profileBio: UILabel!
    
//    var selectedQuestion: PFObject!
    var currentUser: PFUser!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
