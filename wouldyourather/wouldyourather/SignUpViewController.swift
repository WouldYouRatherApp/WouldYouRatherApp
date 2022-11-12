//
//  SignUpViewController.swift
//  wouldyourather
//
//  Created by Matthew Nguyen on 11/11/22.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var fullNamefField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user["fullName"] = fullNamefField.text
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
            }
            else {
                print("Error: \(error?.localizedDescription ?? "sign up broke")")
            }
            
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
