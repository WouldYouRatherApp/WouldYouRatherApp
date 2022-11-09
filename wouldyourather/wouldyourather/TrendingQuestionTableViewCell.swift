//
//  TrendingQuestionTableViewCell.swift
//  wouldyourather
//
//  Created by Kenny Bui on 11/9/22.
//

import UIKit

class TrendingQuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profilepic: UIImageView!
    
    @IBAction func likePost(_ sender: Any) {
    }
    
    var favorited:Bool = false
        
        func setFavorite(_ isFavorited:Bool) {
            favorited = isFavorited
            if (favorited) {
                likeButton.setImage(UIImage(named: "heart_filled"), for: UIControl.State.normal)
            }
            else {
                likeButton.setImage(UIImage(named: "heart_empty"), for: UIControl.State.normal)
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
