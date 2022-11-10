//
//  QuestionTableViewCell.swift
//  wouldyourather
//
//  Created by Heather Nguyen on 10/27/22.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var pfp: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option2Label: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var upvoteButton: UIButton!

    @IBAction func upvoteQuestion(_ sender: Any) {
    }
    
    var upvoted:Bool = false
    func setUpvote(_ isUpvoted:Bool) {
        upvoted = isUpvoted
        if (upvoted) {
            upvoteButton.setImage(UIImage(named:"heart_empty"), for:UIControl.State.normal)
        } else {
            upvoteButton.setImage(UIImage(named:"heart_filled"), for:UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
