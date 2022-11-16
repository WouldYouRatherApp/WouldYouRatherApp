//
//  ProfileFeedViewController.swift
//  wouldyourather
//
//  Created by Francisco Lira on 11/14/22.
//

import UIKit
import Parse

class ProfileFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var profileUsername: UILabel!
    
    
    @IBOutlet weak var profileBio: UILabel!
    
    
    @IBOutlet weak var userProfileInfo: UIView!
    
    var questions = [PFObject]()
    var selectedQuestion: PFObject!
    
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    let myRefreshControl = UIRefreshControl()

    
    @IBAction func onLogoutButton(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        let delegate = self.view.window?.windowScene?.delegate as! SceneDelegate
        delegate.window?.rootViewController = loginViewController
        PFUser.logOut()
        
    }
    
    
    @IBOutlet weak var profileQuestionTableView: UITableView!
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
    

    override func viewDidLoad() {
        profileQuestionTableView.dataSource = self
        profileQuestionTableView.delegate = self
        
        

        super.viewDidLoad()
        myRefreshControl.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        profileQuestionTableView.refreshControl = myRefreshControl
        
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.bounds.width / 2
        
        userImage.layer.borderColor = UIColor.black.cgColor
        userImage.layer.borderWidth = 4
        
        let currUserName = PFUser.current()?.username
        let currObjectId = (PFUser.current()?.objectId)!
        let currentUser = PFUser.current()! // currentUser is now assigned to the object containing the info about the current user
        
        let query = PFQuery(className: "User")
        self.profileUsername.text = PFUser.current()?.username
        
        let bio = currentUser["bio"] as? String
        if bio != nil {
            self.profileBio.text = currentUser["bio"] as! String
        }
        else{
            self.profileBio.text = "You currently do not have a bio..."
        }
        
//        self.profileBio.text = PFUser.current()?.object["bio"];
        
        query.getObjectInBackground(withId: currObjectId){(object, error) -> Void in
            
            if object != nil && error == nil{
                print(object!["fullName"] as! String)
                print("YUUSSSSSS")
            }
            else{
                print("NAURRRR")
                print(object)
                print(error)
            }
        }
//        userImage = currentUser["profilePicture"] as! UIImageView
        
        let imageFile = currentUser["profilePicture"] as! PFFileObject
        
        if imageFile != nil{
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            userImage.af.setImage(withURL: url)
        }
       
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let currentUser = PFUser.current()!
        let currObjectId = (PFUser.current()?.objectId)!
        let currentAuthor = currObjectId
        print("PRINTING CURRENT AUTHOR: " + currentAuthor)
        // to check if there is an author populated in the console
//        let predicate = NSPredicate(format:"author == \(currentAuthor)")
//
//        let query = PFQuery(className: "Questions", predicate: predicate)
        let query = PFQuery(className: "Question")
        query.whereKey("author", equalTo: currentUser)
        query.includeKeys(["author", "comments", "comments.author", "upvotes"])
        query.limit = 35
        query.findObjectsInBackground { (questions, error) in
            if questions != nil {
                self.questions = questions!
                self.profileQuestionTableView.reloadData()
                print(questions!)
                print("questions exist")
            } else {
                print("no questions")
            }
        }
        self.myRefreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(questions.count)
        return questions.count
    }
    
    @objc func option1Tapped(tapGestureRecognizer: UITapGestureRecognizer){
        let touch = tapGestureRecognizer.location(in: profileQuestionTableView)
        let indexPath = profileQuestionTableView.indexPathForRow(at: touch)
        let cell = profileQuestionTableView.cellForRow(at: indexPath!) as? QuestionTableViewCell
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
        let touch = tapGestureRecognizer.location(in: profileQuestionTableView)
        let indexPath = profileQuestionTableView.indexPathForRow(at: touch)
        let cell = profileQuestionTableView.cellForRow(at: indexPath!) as? QuestionTableViewCell
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
        let cell = profileQuestionTableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell") as! QuestionTableViewCell
        let question = questions.reversed()[indexPath.row]
        
        let user = question["author"] as! PFUser
        
        cell.pfp.layer.masksToBounds = true
        cell.pfp.layer.cornerRadius = cell.pfp.bounds.width / 2

        cell.usernameLabel.text = user["username"] as? String
        cell.fullNameLabel.text = user["fullName"] as? String

        cell.option1Label.text = question["choiceA"] as? String
        cell.option2Label.text = question["choiceB"] as? String

        let currentUser = PFUser.current()!
        let questionVotedUsers = (question["votedUsers"] as? [PFObject]) ?? []
        let userObjectId = currentUser.objectId
        
//        print(currentUser)
//        print(user.objectId)
//        print(questionVotedUsers)
//        print(questionVotedUsers.contains(currentUser))
        print("percentage text:")
        print(cell.percentagesLabel.text)
        var userVoted:Bool = false
        for person in questionVotedUsers {
            if (userObjectId == person.objectId) {
                userVoted = true
            }
        }
        
        // current bug: trying to make sure users can't vote more than once
        if userVoted == true {
            print("USER IS HAS ALREADY VOTED FOR THIS QUESTION")
            print(indexPath.row)
            cell.option1Label.isUserInteractionEnabled = false
            cell.option2Label.isUserInteractionEnabled = false
            
            let votesA = question["votesA"] as? Double
            let votesB = question["votesB"] as? Double
            let totalVotes = votesA! + votesB!
            let percA = Int(floor((votesA! / totalVotes) * 100))
            let percB = Int(floor((votesB! / totalVotes) * 100))

            cell.percentagesLabel.text = String(percA) + "% - " + String (percB) + "%"
        } else {
            print("USER HASNT VOTED FOR THIS QUESTION")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // find selected question
        print("loading comments")
        let view = sender as? UIView
        let position = view?.convert(CGPoint.zero, to: self.profileQuestionTableView)
        let path = profileQuestionTableView.indexPathForRow(at: position!) as? IndexPath
        
        if (path != nil) {
            let question = questions[path!.row]
            let comments = (question["comments"] as? [PFObject]) ?? []
            
            // pass question id to CommentsViewController
            let commentsViewController = segue.destination as! CommentsViewController
            commentsViewController.selectedQuestion = question
            commentsViewController.comments = comments
        }

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

