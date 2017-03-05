//
//  GoalViewController.swift
//  Pocket Portions
//
//  Created by Chris on 3/5/17.
//  Copyright © 2017 Pocket Portions. All rights reserved.
//

import UIKit
import Firebase

class GoalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let uid = FIRAuth.auth()?.currentUser?.uid
    let ref = FIRDatabase.database().reference(fromURL: "https://pocket-portions.firebaseio.com/")

    
    @IBAction func fatLoss(_ sender: Any) {
        
        let usersRef = ref.child("users").child(uid!)
        let values = ["cMax": "20", "cMin": "10",
                      "fMax": "40", "fMin": "30",
                      "pMax": "50", "pMin": "40",
                      "goalType": "fat"]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })
        
        performSegue(withIdentifier: "goalToRecs", sender: nil)

    }

    @IBAction func muscleBuilding(_ sender: Any) {
        
        let usersRef = ref.child("users").child(uid!)
        let values = ["cMax": "60", "cMin": "40",
                      "fMax": "25", "fMin": "15",
                      "pMax": "35", "pMin": "25",
                      "goalType": "muscle"]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })
        
        performSegue(withIdentifier: "goalToRecs", sender: nil)
    }
    @IBAction func maintenance(_ sender: Any) {
        
        let usersRef = ref.child("users").child(uid!)
        let values = ["cMax": "50", "cMin": "30",
                      "fMax": "35", "fMin": "25",
                      "pMax": "35", "pMin": "25",
                      "goalType": "carbs"]
        usersRef.updateChildValues(values as [AnyHashable: Any], withCompletionBlock: {
            (err, ref) in
            
            if err != nil{
                print(err)
                return
            }
            print("Saved Info")
        })
        
        performSegue(withIdentifier: "goalToRecs", sender: nil)
    }
    /*
     @IBAction func maintenance(_ sender: Any) {
     }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
