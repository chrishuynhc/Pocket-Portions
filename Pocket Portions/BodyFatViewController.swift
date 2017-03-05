//
//  BodyFatViewController.swift
//  Pocket Portions
//
//  Created by Chris on 3/5/17.
//  Copyright © 2017 Pocket Portions. All rights reserved.
//

import UIKit
import Firebase

class BodyFatViewController: UIViewController {

    @IBOutlet weak var bodyFatPercentage: UILabel!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        //Welcome Back! Title
        let logo = UIImage(named: "bodyFat")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        //Back Arrow
        let backArrowimage = UIImage(named: "backArrow")
        let backArrow = UIBarButtonItem(image: backArrowimage, style: .plain, target: self, action: #selector(LoginViewController.backButtonHit))
        backArrow.tintColor = UIColor(red: 86/255.0, green: 162/255.0, blue: 239/255.0, alpha: 1)
        self.navigationItem.leftBarButtonItem = backArrow

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        bodyFatPercentage.text = String(Int(slider.value)) + "%"
    }

    @IBAction func `continue`(_ sender: Any) {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference(fromURL: "https://pocket-portions.firebaseio.com/")
        let usersRef = ref.child("users").child(uid!)
        let values = ["bodyFat": String(Double(slider.value)/100)]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })
        
        performSegue(withIdentifier: "bodyToActivity", sender: nil)
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
