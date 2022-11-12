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
        print(questions.count)
        return questions.count
    }
    

    
    @objc func option1Tapped(tapGestureRecognizer: UITapGestureRecognizer){
//        let view = tapGestureRecognizer.view
//        let indexPath = tableView.indexPathForView(view)
//
//        let question = questions[indexPath.row]

        
        print(tapGestureRecognizer.view)
        print(tapGestureRecognizer)
        print("tapped")
        
        let touch = tapGestureRecognizer.location(in: questionTableView)
        let indexPath = questionTableView.indexPathForRow(at: touch)
        print(indexPath!.row)
        
        let question = questions[indexPath!.row]
        print(question["votesA"])
        // let id = question["objectId"]
        question.incrementKey("votesA")
        
        question.saveInBackground {(success, error) in
            if (success){
                print("vote saved")
            } else {
                print("error saving vote")
            }
        }
        
        print(question)
        print(question["votesA"])
        
//        let query = PFQuery(className:"Question")
//        query.getObjectInBackground(withId: id) { (question: PFObject?, error: Error?) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let question = question {
//                question["votesA"] = question["votesA"] as! Int + 1
//                question.saveInBackground()
//            }
//        }
        
        print(question["votesA"] as! Int)
    }

    @objc func option2Tapped(tapGestureRecognizer: UITapGestureRecognizer){
//        let view = tapGestureRecognizer.view
//        let indexPath = tableView.indexPathForView(view)
//
//        let question = questions[indexPath.row]

        
        print(tapGestureRecognizer.view)
        print(tapGestureRecognizer)
        print("tapped")
        
        let touch = tapGestureRecognizer.location(in: questionTableView)
        let indexPath = questionTableView.indexPathForRow(at: touch)
        print(indexPath!.row)
        
        let question = questions[indexPath!.row]
        print(question["votesB"])
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = questionTableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell") as! QuestionTableViewCell
//        let cell = QuestionTableViewCell()
        let question = questions[indexPath.row]
        
        let user = question["author"] as! PFUser
//        let upvotedQuestions = user["upvotedQuestions"] as! [String]
        print(user["upvotedQuestions"])
        cell.usernameLabel.text = user["username"] as? String
        cell.fullNameLabel.text = user["fullName"] as? String

        cell.option1Label.text = question["choiceA"] as? String
        cell.option2Label.text = question["choiceB"] as? String
        
        print(cell.option1Label)
        
        //Adding tap gesture
        let cellOption1Tapped = UITapGestureRecognizer(target: self, action:     #selector(option1Tapped))
        cell.option1Label.isUserInteractionEnabled = true// UILabel made available for touch interaction
        cell.option1Label.addGestureRecognizer(cellOption1Tapped) //gesture added
        
        let cellOption2Tapped = UITapGestureRecognizer(target: self, action:     #selector(option2Tapped))
        cell.option2Label.isUserInteractionEnabled = true// UILabel made available for touch interaction
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
