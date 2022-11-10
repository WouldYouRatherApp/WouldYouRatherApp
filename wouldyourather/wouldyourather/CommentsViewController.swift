//
//  CommentsViewController.swift
//  wouldyourather
//
//  Created by Heather Nguyen on 11/7/22.
//

import UIKit
import MessageInputBar
import Parse

class CommentsViewController: UIViewController, MessageInputBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    var questions = [PFObject]()
    var comments = [PFObject]()
    var commentsArray: [String] = []
    var selectedQuestion: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentBar.inputTextView.placeholder = "Add a comment.."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note: )), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let query = PFQuery(className: "comments")
        query.includeKeys(["author"])
        query.limit = 20
        query.findObjectsInBackground { (comments, error) in
            if comments != nil {
                self.comments = comments!
                self.tableView.reloadData()
                print("comments exist")
                print(comments?[0])
                print(comments?.count)
            } else {
                print("no comments")
            }
        }
    }
    
    // loading comments
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let question = questions[section]
//        let comments = (questions["comments"] as? [PFObject]) ?? []
//        print(comments[0])
        
//        return comments.count + 1
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let question = questions[indexPath.section]
        let comments = (question["comments"] as? [PFObject]) ?? []
        
        if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell") as! CommentTableViewCell
            
            let comment = comments[indexPath.row - 1]
            cell.commentTextLabel.text = comment["text"] as? String
            
            let user = comment["author"] as? PFUser
            cell.usernameLabel.text = user?.username
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            
            return cell
        }
    }

    
    
    // functions for add comment keyboard
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // Create the comment
        let comment = PFObject(className: "comments")
        comment["text"] = text
        comment["question"] = selectedQuestion
        comment["author"] = PFUser.current()!

        selectedQuestion.add(comment, forKey: "comments")

        selectedQuestion.saveInBackground{ (success, error) in
            if success {
                print("comment saved")
            } else {
                print("error saving comment")
            }
        }
        
        tableView.reloadData()
        
        // Clear and dismiss the input bar
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
}

