//
//  AddKidViewController.swift
//  His Kids
//
//  Created by Saher  Salib on 9/20/16.
//  Copyright © 2016 Samer Salib. All rights reserved.
//

import UIKit

class AddKidViewController: UIViewController {
    var classroomID = 3
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.keyboardType = UIKeyboardType.decimalPad
        saveButton.isEnabled = false
    }
    
    @IBAction func inputFirstName(_ sender: AnyObject) {
        if (firstName.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            saveButton.isEnabled = false
        }
        else{
            saveButton.isEnabled = true
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addKid(_ sender: AnyObject) {
        
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
