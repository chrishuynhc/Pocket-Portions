//
//  InfoViewController.swift
//  Pocket Portions
//
//  Created by Chris on 3/5/17.
//  Copyright © 2017 Pocket Portions. All rights reserved.
//

import UIKit
import Firebase

class InfoViewController: UIViewController {

    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var male: UIButton!
    @IBOutlet weak var female: UIButton!
    
    var gender: String? = "male"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        //Title
        let logo = UIImage(named: "whatIsYour")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let pressedImg = UIImage(named: "mOn")
    let notpressedImg = UIImage(named: "mOff")
    let pressedImgF = UIImage(named: "fOn")
    let notpressedImgF = UIImage(named: "fOff")


    
    @IBAction func malePressed(_ sender: Any) {
        
        
        if (male.isSelected == true) {
            male.setImage(notpressedImg, for: UIControlState())
            male.isSelected = false
            female.setImage(pressedImgF, for: UIControlState())
            female.isSelected = true
            gender = "female"
        } else {
            male.setImage(pressedImg, for: UIControlState())
            male.isSelected = true
            female.setImage(notpressedImgF, for: UIControlState())
            female.isSelected = false
            gender = "male"
        }

    }
    
    @IBAction func femalePressed(_ sender: Any) {
        
        if (female.isSelected == true) {
            female.setImage(notpressedImgF, for: UIControlState())
            female.isSelected = false
            male.setImage(pressedImg, for: UIControlState())
            male.isSelected = true
            gender = "male"
        } else {
            female.setImage(pressedImgF, for: UIControlState())
            female.isSelected = true
            male.setImage(notpressedImg, for: UIControlState())
            male.isSelected = false
            gender = "female"
        }

    }
    
    func DismissKeyboard(){
        
        view.endEditing(true)
    }
    
    @IBAction func `continue`(_ sender: Any) {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference(fromURL: "https://pocket-portions.firebaseio.com/")
        let usersRef = ref.child("users").child(uid!)
        let values = ["age": age.text!, "height": height.text! , "weight": weight.text!, "gender": gender]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })

        
        performSegue(withIdentifier: "infoToBodyFat", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
