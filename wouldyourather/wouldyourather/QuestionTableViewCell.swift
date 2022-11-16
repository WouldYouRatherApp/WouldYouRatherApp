//
//  QuestionTableViewCell.swift
//  wouldyourather
//
//  Created by Heather Nguyen on 10/27/22.
//

import UIKit
import Parse

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var pfp: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option2Label: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var upvoteButton: UIButton!

    @IBOutlet weak var percentagesLabel: UILabel!
    
    @IBOutlet weak var photo1Image: UIImageView!
    @IBOutlet weak var photo2Image: UIImageView!

    var upvoted:Bool = false
    var selectedQuestion: PFObject!
    var currentUser: PFUser!

    func setUpvote(_ isUpvoted:Bool) {
        print("upvoted in cell file")
        print(upvoted)
        upvoted = isUpvoted
        if (upvoted) {
            upvoteButton.setImage(UIImage(named:"heart_filled"), for:UIControl.State.normal)
        } else {
            upvoteButton.setImage(UIImage(named:"heart_empty"), for:UIControl.State.normal)
        }
    }
    
    @IBAction func upvoteQuestion(_ sender: Any) {
        let toBeUpvoted = !upvoted
        if (toBeUpvoted) {
            self.setUpvote(true)
            selectedQuestion.incrementKey("upvotes")
            selectedQuestion.add(currentUser!, forKey: "upvotedUsers")
            
            selectedQuestion.saveInBackground {(success, error) in
                if (success){
                    print("upvote saved")
                } else {
                    print("error saving upvote")
                }
            }
        } else {
            self.setUpvote(false)
            selectedQuestion.incrementKey("upvotes", byAmount: -1)
            selectedQuestion.remove(currentUser!, forKey: "upvotedUsers")
            
            selectedQuestion.saveInBackground {(success, error) in
                if (success){
                    print("un upvote saved")
                } else {
                    print("error saving upvote")
                }
            }
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
