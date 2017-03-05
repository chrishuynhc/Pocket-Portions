//
//  ActivityViewController.swift
//  Pocket Portions
//
//  Created by Chris on 3/5/17.
//  Copyright © 2017 Pocket Portions. All rights reserved.
//

import UIKit
import Firebase

class ActivityViewController: UIViewController {

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
        
        //Title
        let logo = UIImage(named: "yourActivity")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        //Back Arrow
        let backArrowimage = UIImage(named: "backArrow")
        let backArrow = UIBarButtonItem(image: backArrowimage, style: .plain, target: self, action: #selector(LoginViewController.backButtonHit))
        backArrow.tintColor = UIColor(red: 86/255.0, green: 162/255.0, blue: 239/255.0, alpha: 1)
        self.navigationItem.leftBarButtonItem = backArrow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let uid = FIRAuth.auth()?.currentUser?.uid
    let ref = FIRDatabase.database().reference(fromURL: "https://pocket-portions.firebaseio.com/")
    
    
    @IBAction func sedentary(_ sender: Any) {
        
        let usersRef = ref.child("users").child(uid!)
        let values = ["activity": "1.2"]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })
        
        performSegue(withIdentifier: "actToRecs", sender: nil)
    }

    @IBAction func lightly(_ sender: Any) {
        
        let usersRef = ref.child("users").child(uid!)
        let values = ["activity": "1.375"]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })
        
        performSegue(withIdentifier: "actToRecs", sender: nil)
    }
    
    @IBAction func moderately(_ sender: Any) {
        
        let usersRef = ref.child("users").child(uid!)
        let values = ["activity": "1.55"]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })
        
        performSegue(withIdentifier: "actToRecs", sender: nil)    }
    
    @IBAction func very(_ sender: Any) {
        
        let usersRef = ref.child("users").child(uid!)
        let values = ["activity": "1.725"]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })
        
        performSegue(withIdentifier: "actToRecs", sender: nil)
    }
    
    @IBAction func extremely(_ sender: Any) {
        
        let usersRef = ref.child("users").child(uid!)
        let values = ["activity": "1.9"]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })
        
        performSegue(withIdentifier: "actToRecs", sender: nil)
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
