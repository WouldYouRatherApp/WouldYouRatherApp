//
//  HomeFeedViewController.swift
//  wouldyourather
//
//  Created by Heather Nguyen on 10/27/22.
//

import UIKit
import Parse
import AlamofireImage

class HomeFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var questionTableView: UITableView!
    
    var questions = [PFObject]()
    var selectedQuestion: PFObject!
    var numberOfPosts = 100
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        questionTableView.dataSource = self
        questionTableView.delegate = self
        
        super.viewDidLoad()
        myRefreshControl.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        questionTableView.refreshControl = myRefreshControl
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Question")
        query.includeKeys(["author", "comments", "comments.author"])
        query.limit = 100
        query.findObjectsInBackground { (questions, error) in
            if questions != nil {
                self.questions = questions!
                self.questionTableView.reloadData()
                //                print("questions exist")
            } else {
                //                print("no questions")
            }
        }
        self.myRefreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    
    @objc func option1Tapped(tapGestureRecognizer: UITapGestureRecognizer){
        let touch = tapGestureRecognizer.location(in: questionTableView)
        let indexPath = questionTableView.indexPathForRow(at: touch)
        let cell = questionTableView.cellForRow(at: indexPath!) as? QuestionTableViewCell
        let question = questions[indexPath!.row]
        
        let user = PFUser.current()!
        let votedUsersArr = (question["votedUsers"] as? [PFObject]) ?? []
        
        //        print("question's votedUsers")
        //        print(votedUsersArr)
        //        print("user array?")
        //        print(user)
        //        print(votedUsersArr.contains(user))
        
        if (!votedUsersArr.contains(user)) {
            question.incrementKey("votesA")
            question.add(user, forKey: "votedUsers")
            
            question.saveInBackground {(success, error) in
                if (success){
                    print("vote saved")
                } else {
                    print("error saving vote")
                }
            }
        } else {
            print("user has already voted")
        }
        
        let votesA = question["votesA"] as? Double
        let votesB = question["votesB"] as? Double
        let totalVotes = votesA! + votesB!
        let percA = Int(floor((votesA! / totalVotes) * 100))
        let percB = Int(floor((votesB! / totalVotes) * 100))
        
        cell!.percentagesLabel.text = String(percA) + "% - " + String (percB) + "%"
    }
    
    @objc func option2Tapped(tapGestureRecognizer: UITapGestureRecognizer){
        let touch = tapGestureRecognizer.location(in: questionTableView)
        let indexPath = questionTableView.indexPathForRow(at: touch)
        let cell = questionTableView.cellForRow(at: indexPath!) as? QuestionTableViewCell
        let question = questions[indexPath!.row]
        
        let user = PFUser.current()!
        let votedUsersArr = (question["votedUsers"] as? [PFObject]) ?? []
        
        if (!votedUsersArr.contains(user)) {
            question.incrementKey("votesB")
            question.add(user, forKey: "votedUsers")
            
            question.saveInBackground {(success, error) in
                if (success){
                    print("vote saved")
                } else {
                    print("error saving vote")
                }
            }
        }  else {
            print("user has already voted")
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
        let question = questions.reversed()[indexPath.row]
        
        let user = question["author"] as! PFUser
        
        cell.usernameLabel.text = user["username"] as? String
        cell.fullNameLabel.text = user["fullName"] as? String
        
        cell.option1Label.text = question["choiceA"] as? String
        cell.option2Label.text = question["choiceB"] as? String
        
        let currentUser = PFUser.current()!
        let questionVotedUsers = (question["votedUsers"] as? [PFObject]) ?? []
        let userObjectId = currentUser.objectId
        
        let imageFile1 = question["imageA"] as! PFFileObject
        let imageFile2 = question["imageB"] as! PFFileObject
        let urlString1 = imageFile1.url!
        let urlString2 = imageFile2.url!
        let url1 = URL(string: urlString1)!
        let url2 = URL(string: urlString2)!
        
        cell.photo1Image.af.setImage(withURL: url1)
        cell.photo2Image.af.setImage(withURL: url2)
        
        
        //        print(currentUser)
        //        print(user.objectId)
        //        print(questionVotedUsers)
        //        print(questionVotedUsers.contains(currentUser))
        var userVoted:Bool = false
        for person in questionVotedUsers {
            if (userObjectId == person.objectId) {
                userVoted = true
            }
        }
        
        // current bug: trying to make sure users can't vote more than once
        if userVoted == true {
            //            print("USER IS HAS ALREADY VOTED FOR THIS QUESTION")
            //            print(indexPath.row)
            cell.option1Label.isUserInteractionEnabled = false
            cell.option2Label.isUserInteractionEnabled = false
            
            let votesA = question["votesA"] as? Double
            let votesB = question["votesB"] as? Double
            let totalVotes = votesA! + votesB!
            let percA = Int(floor((votesA! / totalVotes) * 100))
            let percB = Int(floor((votesB! / totalVotes) * 100))
            
            cell.percentagesLabel.text = String(percA) + "% - " + String (percB) + "%"
        } else {
            //            print("USER HASNT VOTED FOR THIS QUESTION")
            cell.option1Label.isUserInteractionEnabled = true
            cell.option2Label.isUserInteractionEnabled = true
            cell.percentagesLabel.text = ""
        }
        
        //Adding tap gesture
        let cellOption1Tapped = UITapGestureRecognizer(target: self, action:     #selector(option1Tapped))
        cell.option1Label.addGestureRecognizer(cellOption1Tapped) //gesture added
        
        let cellOption2Tapped = UITapGestureRecognizer(target: self, action:     #selector(option2Tapped))
        cell.option2Label.addGestureRecognizer(cellOption2Tapped) //gesture added
        self.myRefreshControl.endRefreshing()
        
        let questionUpvotedUsers = (question["upvotedUsers"] as? [PFObject]) ?? []
        var hereUpvoted:Bool = false
        for person in questionUpvotedUsers {
            if (userObjectId == person.objectId) {
                hereUpvoted = true
                cell.upvoted = true
            }
        }
        if hereUpvoted == true {
            cell.setUpvote(true)
        } else {
            cell.setUpvote(false)
        }
        cell.selectedQuestion = question
        cell.currentUser = currentUser
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // find selected question
        let view = sender as? UIView
        let position = view?.convert(CGPoint.zero, to: self.questionTableView)
        if (position != nil) {
            let path = questionTableView.indexPathForRow(at: position!) as? IndexPath
            if (path != nil) {
                let question = questions.reversed()[path!.row]
                question.fetchIfNeededInBackground()
                let comments = (question["comments"] as? [PFObject]) ?? []
                
                // pass question id to CommentsViewController
                let commentsViewController = segue.destination as! CommentsViewController
                commentsViewController.selectedQuestion = question
                commentsViewController.comments = comments
            }
            
        }
        
    }
}
