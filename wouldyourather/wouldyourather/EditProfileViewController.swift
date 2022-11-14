//
//  EditProfileViewController.swift
//  wouldyourather
//
//  Created by Francisco Lira on 11/12/22.
//

import UIKit
import AlamofireImage
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var captionBio: UITextField!
    
    @IBOutlet weak var uploadProfilePic: UIImageView!
    
    @IBOutlet weak var sumbitButton: UIButton!
    @IBOutlet weak var captionFullName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sumbitButton.layer.cornerRadius = 15
        
//        uploadProfilePic.layer.masksToBounds = true
//        uploadProfilePic.layer.cornerRadius = uploadProfilePic.bounds.width / 2
      
        uploadProfilePic.layer.cornerRadius = uploadProfilePic.frame.size.width / 2
        uploadProfilePic.clipsToBounds = true
        
        uploadProfilePic.layer.borderColor = UIColor.darkGray.cgColor
        uploadProfilePic.layer.borderWidth = 4
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onUploadProfilePicBtn(_ sender: Any) {
       
        
        let picker = UIImagePickerController()
        picker.delegate = self // when pic is taken, calls back
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            //            present(picker, animated: true)
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil) // will show photo album
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        
        let scaledImage = image.af_imageScaled(to: size)
        
        //        dismiss(animated: true, completion: nil)
        
        uploadProfilePic.image = scaledImage
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onSubmitBtn(_ sender: Any) {
        
       
        
        let query = PFQuery(className: "User")
        var prefObj = PFObject(className: "User")
        let imageData = uploadProfilePic.image!.pngData()
        let picFile = PFFileObject(name: "image.png", data: imageData!)
        let newBio = self.captionBio.text!
        let newFullName = self.captionFullName.text!
//        let currUserName = PFUser.current()?.username
        let currObjectId = (PFUser.current()?.objectId)!
        print(currObjectId)
        
//        if let currUserName = PFUser.current()?.username {
//                    query.whereKey("username", equalTo: currUserName)
//                }
//        query.findObjectsInBackground{
//            (object, error) in
//            if error == nil {
//                print("HELLLLOOOO")
//                if let object = object {
//                    print("OHHH NAUR")
//
//
//
//                        print("OHHH CHIZZZLLLESS")
//                        object["bio"] = "Hello"
//                        object["fullName"] = "newFullName"
//                        //                    objects["profilePicture"] = picFile
//                        print("Update successful")
//                        object.saveInBackground()
//
//
//                      }
//                  }
//        }

        
        
        //        if let currUserName = PFUser.current()?.username {
        //            prefQuery.whereKey("username", equalTo: currUserName)
        //        }
        //
        //        query.getObjectInBackground(withId: currObjectId){
        //            (object, error) ->
        //            Void in
        //            if object != nil {
        //                print(object!["username"]as! String)
        //                object!["bio"] = self.captionBio.text!
        //                object!["fullName"] = self.captionFullName.text!
        //                object!.saveInBackground()
        //            }
        //        }
//        query.getObjectInBackground(withId:"DhHKanjiUW") {
//            (object, error) -> Void in
//            if error == nil {
//                print("MOOOOOOM")
//                object!["fullName"] = self.captionFullName.text!
//                object!["bio"] = self.captionBio.text!
//                object!["profilePicture"] = file
//                print("Update successful")
//                //                        object.saveInBackground()
//                object!.saveInBackground()
//
//            }
//        }
        
//        query.getObjectInBackground(withId: "DhHKanjiUW") {  (object, error) -> Void in
//          if error == nil {
//            // Success!
//            print(object)
//          } else {
//           // Fail!
//          }
//        }
        
        
        
    }
               
        
        
//        prefQuery.getObjectInBackground(withId:currObjectId) {
//            (objects, error)  in
//            if error == nil {
//                if let objects = objects {
//                    for object in objects {
//                        object["fullName"] = self.captionFullName.text!
//                        object["bio"] = self.captionBio.text!
//                        object["profilePicture"] = file
//                        print("Update successful")
//                        //                        object.saveInBackground()
//                        object.saveInBackground { (success, error) in
//                            if success {
//                                self.dismiss(animated: true, completion: nil)
//                                print("posted into Parse!")
//
//                            } else {
//                                print("error saving post!")
//                            }
//                        }
//
//                    }
//                }
//            }
//        }
    
}
  

