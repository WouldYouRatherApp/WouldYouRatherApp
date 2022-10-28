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
    @IBOutlet weak var heartButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
