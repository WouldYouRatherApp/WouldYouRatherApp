//
//  HomeFeedViewController.swift
//  wouldyourather
//
//  Created by Heather Nguyen on 10/27/22.
//

import UIKit
import Parse

class HomeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var questionTableView: UITableView!
    
    var questions = [PFObject]()
    var selectedQuestion: PFObject!
    
    override func viewDidLoad() {
        questionTableView.dataSource = self
        questionTableView.delegate = self

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "User")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 10
        query.findObjectsInBackground { (questions, error) in
            if questions != nil {
                self.questions = questions!
                self.questionTableView.reloadData()
                print("questions exist")
            } else {
                print("no questions")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("hello2")
        print(questions.count)
        return questions.count
//        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionTableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell") as! QuestionTableViewCell
//        let question = questions[indexPath.row]
        
//        let user = question["author"] as! PFUser
//        cell.usernameLabel.text = user.username
//        cell.fullNameLabel.text = user["fullName"] as? String
//
//        cell.option1Label.text = question["choiceA"] as? String
//        cell.option2Label.text = question["choiceB"] as? String
        
        cell.fullNameLabel.text = "Jane Doe"
        cell.usernameLabel.text = "@JaneDoe"
        cell.option1Label.text = "have telekinesis"
        cell.option2Label.text = "have telepathy"
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
