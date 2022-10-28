//
//  PostViewController.swift
//  wouldyourather
//
//  Created by Anshi on 10/28/22.
//

import UIKit
import AlamofireImage
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var choiceAImageView: UIImageView!
    @IBOutlet weak var choiceBImageView: UIImageView!
    @IBOutlet weak var choiceAField: UITextField!
    @IBOutlet weak var choiceBField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["choiceA"] = choiceAField.text
        post["choiceB"] = choiceBField.text
        post["author"] = PFUser.current()!
        
        let imageDataA = choiceAImageView.image!.pngData()
        let imageDataB = choiceBImageView.image!.pngData()
        let fileA = PFFileObject(name: "image.png", data: imageDataA!)
        let fileB = PFFileObject(name: "image.png", data: imageDataB!)
        
        post["imageA"] = fileA
        post["imageB"] = fileB
        
        post.saveInBackground { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
                print("saved")
            } else {
                print("error!")
            }
        }
    }
    
    @IBAction func onChoiceACameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func onChoiceBCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        choiceAImageView.image = scaledImage
        choiceBImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
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
