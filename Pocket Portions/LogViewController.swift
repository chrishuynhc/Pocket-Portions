//
//  LogViewController.swift
//  Pocket Portions
//
//  Created by Chris on 3/5/17.
//  Copyright © 2017 Pocket Portions. All rights reserved.
//

import UIKit
import Firebase

class LogViewController: UIViewController {

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
        let logo = UIImage(named: "yourMeals")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem = add
        
        /* Add Gear Later
        let addButtonImage = UIImage(named: "backArrow")
        let backArrow = UIBarButtonItem(image: backArrowimage, style: .plain, target: self, action: #selector(LoginViewController.backButtonHit))
        backArrow.tintColor = UIColor(red: 86/255.0, green: 162/255.0, blue: 239/255.0, alpha: 1)
        self.navigationItem.leftBarButtonItem = backArrow
        */
        findInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func addTapped() {
        performSegue(withIdentifier: "plus", sender: nil)
    }
    
    var basalMetabolicRate: Double = 0.0
    //get user gender
    var gender = "male"//whatever Firebase gender
    var height = 0.0, weight = 0.0, age = 0.0
    var heightInInches: Int = 0
    var activity = 0.0
    var BMR: Double = 0.0
    var TDEE: Double = 0.0
    var fMin = 0.0, fMax = 0.0, cMin = 0.0, cMax = 0.0, pMin = 0.0, pMax = 0.0
    var goalType = ""
    var fat : Double = 0.0
    var protein : Double = 0.0
    var carbohydrates : Double = 0.0
    var defaultArray = [0.0, 0.0, 0.0]
    
    func findInfo() {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                print("WORKED")
                
                
                self.gender = (dictionary["gender"] as? String)!
                self.height = Double((dictionary["height"] as? String)!)! * 2.54
                self.weight = Double((dictionary["weight"] as? String)!)! * 0.454
                self.age = Double((dictionary["age"] as? String)!)!
                
                self.BMR = self.calculateBMR()
                
                self.activity = Double((dictionary["activity"] as? String)!)!
                
                self.goalType = (dictionary["goalType"] as? String)!
                print(self.goalType)
                print(self.gender)
                if (self.goalType == "fat") {
                    
                    print("TEST 123")
                    
                    self.fMin = Double((dictionary["fMin"] as? String)!)! / 100
                    self.fMax = Double((dictionary["fMax"] as? String)!)! / 100
                    self.cMin = Double((dictionary["cMin"] as? String)!)! / 100
                    self.cMax = Double((dictionary["cMax"] as? String)!)! / 100
                    self.pMin = Double((dictionary["pMin"] as? String)!)! / 100
                    self.pMax = Double((dictionary["pMax"] as? String)!)! / 100
                    print ("TEST 345")
                }
                else if (self.goalType == "carbs") {
                    print("TEST 567")
                    self.fMin = Double((dictionary["fMin"] as? String)!)! / 100
                    self.fMax = Double((dictionary["fMax"] as? String)!)! / 100
                    self.cMin = Double((dictionary["cMin"] as? String)!)! / 100
                    self.cMax = Double((dictionary["cMax"] as? String)!)! / 100
                    self.pMin = Double((dictionary["pMin"] as? String)!)! / 100
                    self.pMax = Double((dictionary["pMax"] as? String)!)! / 100
                }
                else if (self.goalType == "muscle") {
                    print("TEST 789")
                    self.fMin = Double((dictionary["fMin"] as? String)!)! / 100
                    self.fMax = Double((dictionary["fMax"] as? String)!)! / 100
                    self.cMin = Double((dictionary["cMin"] as? String)!)! / 100
                    self.cMax = Double((dictionary["cMax"] as? String)!)! / 100
                    self.pMin = Double((dictionary["pMin"] as? String)!)! / 100
                    self.pMax = Double((dictionary["pMax"] as? String)!)! / 100
                }
                
                var results = self.calculateDefault()
                
                for index in 0...5 {
                    
                }
                
            }
            
            
        }, withCancel: nil)
        print("COMPLETED")
        determineRec()
    }
    
    func calculateBMR() -> Double {
        if(gender == "male")
        {
            basalMetabolicRate = 66 + ((13.7) * weight) + (5 * height)-(6.8 * age)
        }
        else if(gender == "female")
        {
            basalMetabolicRate = 655 + ((9.6) * weight) + (1.8 * height)-(4.7 * age)
        }
        return basalMetabolicRate
    }
    func calculateDefault() -> [Double]{
        TDEE = activity * BMR
        print(TDEE)
        fat = ((TDEE * fMin)/9 + (TDEE * fMax)/9)/2
        carbohydrates = ((TDEE * cMin)/4 + (TDEE * cMax)/4)/2
        protein = ((TDEE * pMin)/4 + (TDEE * pMax)/4)/2
        defaultArray = [fat,carbohydrates,protein]
        print(defaultArray)
        return defaultArray
        
    }
    
    var valueArray = ["","","","",""]
    
    func determineRec() {
        
        for index in 0...5 {
        //let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("food").child(String(index)).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                print("WORKED")
                
                
                
                
                self.valueArray[index] = (dictionary["Name"] as? String)!
                
                print("HEREWRAHEWF AWE")
                print(self.valueArray[index])
                
            
            }
            
            
        }, withCancel: nil)
        
    
        }
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
