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
        
        let query = PFQuery(className: "Question")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 20
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
        print(questions.count)
        return questions.count
    }
    

    
    @objc func option1Tapped(tapGestureRecognizer: UITapGestureRecognizer){
        let touch = tapGestureRecognizer.location(in: questionTableView)
        let indexPath = questionTableView.indexPathForRow(at: touch)
        let cell = questionTableView.cellForRow(at: indexPath!) as? QuestionTableViewCell
        let question = questions[indexPath!.row]

        question.incrementKey("votesA")
        
        let user = PFUser.current()!
        question.add(user, forKey: "votedUsers")
        
        question.saveInBackground {(success, error) in
            if (success){
                print("vote saved")
            } else {
                print("error saving vote")
            }
        }
        
        let votesA = question["votesA"] as? Double
        let votesB = question["votesB"] as? Double
        let totalVotes = votesA! + votesB!
        let percA = Int(floor((votesA! / totalVotes) * 100))
        let percB = Int(floor((votesB! / totalVotes) * 100))
        
        cell!.percentagesLabel.text = String(percA) + "%-" + String (percB) + "%"
    }

    @objc func option2Tapped(tapGestureRecognizer: UITapGestureRecognizer){
        let touch = tapGestureRecognizer.location(in: questionTableView)
        let indexPath = questionTableView.indexPathForRow(at: touch)
        let cell = questionTableView.cellForRow(at: indexPath!) as? QuestionTableViewCell
        let question = questions[indexPath!.row]

        question.incrementKey("votesB")
        
        let user = PFUser.current()!
        question.add(user, forKey: "votedUsers")
        
        question.saveInBackground {(success, error) in
            if (success){
                print("vote saved")
            } else {
                print("error saving vote")
            }
        }
        
        let votesA = question["votesA"] as? Double
        let votesB = question["votesB"] as? Double
        let totalVotes = votesA! + votesB!
        let percA = Int(floor((votesA! / totalVotes) * 100))
        let percB = Int(floor((votesB! / totalVotes) * 100))

        cell!.percentagesLabel.text = String(percA) + "% - " + String (percB) + "%"
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionTableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell") as! QuestionTableViewCell
//        let cell = QuestionTableViewCell()
        let question = questions[indexPath.row]
        
        let user = question["author"] as! PFUser
//        let upvotedQuestions = user["upvotedQuestions"] as! [String]
        cell.usernameLabel.text = user["username"] as? String
        cell.fullNameLabel.text = user["fullName"] as? String

        cell.option1Label.text = question["choiceA"] as? String
        cell.option2Label.text = question["choiceB"] as? String

        // print(cell.option1Label)
        let currentUser = PFUser.current()!
        let questionVotedUsers = (question["votedUsers"] as? [PFObject]) ?? []
//        print(questionVotedUsers)
//        print(currentUser)
        
        // current bug: trying to make sure users can't vote more than once
        if questionVotedUsers.contains(currentUser) {
            cell.option1Label.isUserInteractionEnabled = false
            cell.option2Label.isUserInteractionEnabled = false
        } else {
            cell.option1Label.isUserInteractionEnabled = true
            cell.option2Label.isUserInteractionEnabled = true
        }
        
        //Adding tap gesture
        let cellOption1Tapped = UITapGestureRecognizer(target: self, action:     #selector(option1Tapped))
        cell.option1Label.addGestureRecognizer(cellOption1Tapped) //gesture added
        
        let cellOption2Tapped = UITapGestureRecognizer(target: self, action:     #selector(option2Tapped))
        cell.option2Label.addGestureRecognizer(cellOption2Tapped) //gesture added


        //Method called on touch of nameLabel

        
//        if (upvotedQuestions.contains(question)) {
//            cell.setUpvote(true)
//        }
//        else {
//            cell.setUpvote(false)
//        }
//        cell.fullNameLabel.text = "Jane Doe"
//        cell.usernameLabel.text = "@JaneDoe"
//        cell.option1Label.text = "have telekinesis"
//        cell.option2Label.text = "have telepathy"
        
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // find selected question
        print("loading comments")
        let view = sender as? UIView
        let position = view?.convert(CGPoint.zero, to: self.questionTableView)
        let path = questionTableView.indexPathForRow(at: position!) as? IndexPath
        
        if (path != nil) {
            let question = questions[path!.row]
            let comments = (question["comments"] as? [PFObject]) ?? []
            
            // pass question id to CommentsViewController
            let commentsViewController = segue.destination as! CommentsViewController
            commentsViewController.selectedQuestion = question
            commentsViewController.comments = comments
        }

    }

}
