//
//  ProfileFeedViewController.swift
//  wouldyourather
//
//  Created by Francisco Lira on 11/14/22.
//

import UIKit
import Parse

class ProfileFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    @IBOutlet weak var profileTableView: UITableView!
    
//    @IBOutlet weak var userProfileInfo: UIView!
    @IBOutlet weak var profileQuestionTableView: UITableView!
    
    var profiles = [PFObject]()
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
       
        
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        

        super.viewDidLoad()
        
        myRefreshControl.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        profileQuestionTableView.refreshControl = myRefreshControl
        
        myRefreshControl.addTarget(self, action: #selector(viewDidAppear), for: .valueChanged)
        profileTableView.refreshControl = myRefreshControl
        
//        profileTableView.userImage.layer.masksToBounds = true
//        profileTableView.userImage.layer.cornerRadius = userImage.bounds.width / 2
//
//        let currUserName = PFUser.current()?.username
//        let currObjectId = (PFUser.current()?.objectId)!
//        let currentUser = PFUser.current()! // currentUser is now assigned to the object containing the info about the current user
        
//        profileUsername = PFUser.current()?.username
//
//        var query = PFQuery(className: "User")
//        var currentUser = PFUser.current()
//        query.whereKey("username", equalTo: currentUser?.username!)
//        query.getFirstObjectInBackground(){
//          (object: PFObject?, error: NSError?) -> Void in
//          if error != nil || object == nil {
//            print("The getFirstObject request failed.")
//          } else {
//            // The find succeeded.
//                    self.profileUsername = object["username"] as! String!
//            print("Successfully retrieved the object.")
//          }
            
        
//        let query = PFQuery(className: "User")
//        query.findObjectsInBackground {
//            (objects:[PFObject]?, error: Error?) -> Void in
//            if error == nil && (objects != nil) {
//                for object in objects! {
//                    self.profileUsername = currentUser["username"] as? UILabel
//                    self.profileBio = object["bio"] as? UILabel
//                }
//            }
//        }
        


        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let profileQuery = PFQuery(className: "User")
        profileQuery.includeKeys(["username", "fullName", "bio"])
        profileQuery.limit = 35
        profileQuery.findObjectsInBackground { (profiles, error) in
            if profiles != nil {
                self.profiles = profiles!
                self.profileTableView.reloadData()
                print("profile exist")
            } else {
                print("no profile")
            }
        }
        self.myRefreshControl.endRefreshing()

        let query = PFQuery(className: "Question")
        query.includeKeys(["author", "comments", "comments.author", "upvotes"])
        query.order(byAscending: "upvotes")
        query.limit = 35
        query.findObjectsInBackground { (questions, error) in
            if questions != nil {
                self.questions = questions!
                self.profileQuestionTableView.reloadData()
                print("questions exist")
            } else {
                print("no questions")
            }
        }
       
        
       
        
        self.myRefreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == profileQuestionTableView{
            count = questions.count
            print(count)
            print("QUESSTIIOOONS COUNT")
        }
        
        else if tableView == profileTableView{
            count = profiles.count
            print(count)
            print("PROFILELEEEEEE COUNT")
    
        }
        return count!
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
        
        if tableView == profileTableView{
            print("PROFILE INFORMATION DATA")
            let cell = profileTableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
            let profile = profiles[indexPath.row]
            
            let user = profile["username"] as! PFUser

            cell.profileUsername.text = user["username"] as? String
            cell.profileBio.text = user["bio"] as? String

//            cell.userImage.text = question["profilePic"] as? pngData
           
            let currentUser = PFUser.current()!
            let userObjectId = currentUser.objectId
            
            return cell
            
        }
        
        else{
            print("QUESTION VIEW CELL INFORMATION DATA")
            let cell = profileQuestionTableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell") as! QuestionTableViewCell
            let question = questions.reversed()[indexPath.row]
            
            let user = question["author"] as! PFUser

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
        
        return UITableViewCell()
        
        
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

