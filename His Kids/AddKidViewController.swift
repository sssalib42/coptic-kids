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
        var request = URLRequest(url: URL(string: "http://coptdevs.org/LittleOnes/addKid.php")!)
        request.httpMethod = "POST"
        var postString = "classroomID=\(classroomID)"
        if let first = firstName.text {
            postString += "&firstname=\(first)"
        }
        if let last = lastName.text{
            postString += "&lastname=\(last)"
        }
        if let dobStr = dob.text{
            postString += "&dob=\(dobStr)"
        }
        if let phoneStr = phone.text{
            postString += "&phone=\(phoneStr)"
        }
        if let emailStr = email.text{
            postString += "&email=\(emailStr)"
        }
        if let notesStr = notes.text{
            postString += "&notes=\(notesStr)"
        }
        
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            guard let data = data, error == nil else {
                // check for fundamental networking error
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
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
