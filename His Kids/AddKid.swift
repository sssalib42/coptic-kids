//
//  AddKidViewController.swift
//  His Kids
//
//  Created by Saher  Salib on 9/20/16.
//  Copyright © 2016 Samer Salib. All rights reserved.
//

import UIKit
import AVFoundation

class AddKid: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate {
    var classroomID = 9
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
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = false
        phone.keyboardType = UIKeyboardType.decimalPad
        saveButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddKid.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddKid.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
        // Make profile picture behave as a button
        profilePicture.isUserInteractionEnabled = true
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddKid.takePhoto(_:)))
        singleTap.numberOfTapsRequired = 1;
        profilePicture.addGestureRecognizer(singleTap)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        let selectedTextView = findFirstResponder()
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            //if selectedTextView.bottomAnchor < keyboardSize.height{
              //  selectedTextView.frame.origin.y -= keyboardSize.height
            //}NSLayoutYAxisAnchor
        }
        
    }
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    func findFirstResponder()-> UIView
    {
        if (self.isFirstResponder) {
            return self.view
        }
        for subView in self.view.subviews {
            if subView.isFirstResponder {
                return subView
            }
        }
        return self.view
    }
    
    
    
    @IBAction func captureImage(_ sender: AnyObject) {
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized
        {
            // Already Authorized
            // User granted
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
                
            }
        }
        else
        {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted :Bool) -> Void in
                if granted == true
                {
                    
                    
                }
                else
                {
                    // User Rejected
                    let alertController = UIAlertController(title: "Camera access Denied", message: "Please allow camera use", preferredStyle: UIAlertControllerStyle.alert)
                    let DestructiveAction = UIAlertAction(title: "No, thanks", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
                        print("User chose not to allow camera permissions.")
                    }
                    let okAction = UIAlertAction(title: "App settings", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!)
                        } else {
                            // Fallback on earlier versions
                            UIApplication.shared.openURL(NSURL(string:"app-settings:")! as URL)
                        }
                    }
                    alertController.addAction(DestructiveAction)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    //let alertView: UIAlertView = UIAlertView(title: "Camera Permissions", message: "Please allow the app to use the camera", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "App Settings")
                    //alertView.show()
                    //UIApplication.shared.openURL(URL(string: "prefs:root=Settings")!)
                }
            });
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicture.contentMode = .scaleToFill
            profilePicture.image = UIImage(data: UIImageJPEGRepresentation( pickedImage, 0.1)!)
        }
        
        picker.dismiss(animated: true, completion: nil)
        if profilePicture.image == nil {
            print("image is nilllllllll")
        }
    }
    
    // First name is mandatory
    @IBAction func inputFirstName(_ sender: AnyObject) {
        if (firstName.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            saveButton.isEnabled = false
        }
        else{
            saveButton.isEnabled = true
        }
    }
    
    // Use date picker to input the date of birth
    @IBAction func pickDateOfBirth(_ sender: AnyObject) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dob.inputView = datePicker
        datePicker.addTarget(self, action: #selector(AddKid.dateOfBirthPickerChanged(sender:)), for: .valueChanged)
    }
    func dateOfBirthPickerChanged (sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.dateFormat = "dd-MMM-yyyy";
        dob.text = formatter.string(from: sender.date)
    }
    
    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(ImagePicker, animated: true, completion: nil)
    }
    
//    func generateBoundaryString() -> String
//    {
//        return "Boundary-\(UUID().uuidString)"
//    }
    
//    func addKidImage(){
//        let myUrl = URL(string: "http://coptdevs.org/LittleOnes/addKid.php");
//        
//        let request = NSMutableURLRequest(url:myUrl!);
//        request.httpMethod = "POST";
//        
//        request.httpMethod = "POST"
//        var postString = "classroomID=\(classroomID)"
//        if let first = firstName.text {
//            postString += "&firstname=\(first)"
//        }
//        if let last = lastName.text{
//            postString += "&lastname=\(last)"
//        }
//        if let dobStr = dob.text{
//            postString += "&dob=\(dobStr)"
//        }
//        if let phoneStr = phone.text{
//            postString += "&phone=\(phoneStr)"
//        }
//        if let emailStr = email.text{
//            postString += "&email=\(emailStr)"
//        }
//        if let notesStr = notes.text{
//            postString += "&notes=\(notesStr)"
//        }
//
//        if (profilePicture.image == nil)
//        {
//            return
//        }
//        
//        var imageData = UIImagePNGRepresentation(profilePicture.image!)
//        let image_data = imageData?.base64EncodedData()
//        
//        //let image_data = UIImagePNGRepresentation(profilePicture.image!)
//
//
//        if(image_data == nil)
//        {
//            return
//        }
//
//        let session = URLSession.shared
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {            (
//            data, response, error) in
//            
//            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
//                print("error")
//                return
//            }
//            
//            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            
//            print(dataString)
//        }
//        task.resume()       
//    }    

    func testUploadImage(){
        let url = URL(string: "http://coptdevs.org/LittleOnes/testImageUpload.php")
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        if (profilePicture.image == nil)
        {
        return
        }
        
        let image_data = UIImagePNGRepresentation(profilePicture.image!)
        
        if(image_data == nil)
        {
        return
        }
        
        let body = NSMutableData()
        
        let fname = "test.png"
        let mimetype = "image/png"
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody = body as Data
        let session = URLSession.shared
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {            (
        data, response, error) in
        
        guard let _:Data = data, let _:URLResponse = response  , error == nil else {
        print("error")
        return
        }
        
        let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        
        print(dataString)
        }
        task.resume()
    }
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(UUID().uuidString)"
    }

    
    
    @IBAction func addKid(_ sender: AnyObject) {
        
//        var request = URLRequest(url: URL(string: "http://coptdevs.org/LittleOnes/addKid.php")!)
//        request.httpMethod = "POST"
//        var postString = "classroomID=\(classroomID)"
//        if let first = firstName.text {
//            postString += "&firstname=\(first)"
//        }
//        if let last = lastName.text{
//            postString += "&lastname=\(last)"
//        }
//        if let dobStr = dob.text{
//            postString += "&dob=\(dobStr)"
//        }
//        if let phoneStr = phone.text{
//            postString += "&phone=\(phoneStr)"
//        }
//        if let emailStr = email.text{
//            postString += "&email=\(emailStr)"
//        }
//        if let notesStr = notes.text{
//            postString += "&notes=\(notesStr)"
//        }
//        
//        if (profilePicture.image == nil)
//        {
//            return
//        }
//        
//        let imageData = UIImagePNGRepresentation(profilePicture.image!)
//        let image_data = imageData?.base64EncodedData()
//        
//        
//        if let imgStr = image_data{
//            postString += "&image=\(imgStr)"
//        }
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest) {
//            data, response, error in
//            if error != nil {
//                print("error=\(error)")
//                return
//            }
//            guard let data = data, error == nil else {
//                // check for fundamental networking error
//                print("error=\(error)")
//                return
//            }
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
//                // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//            }
//            
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(responseString)")
//        }
//        task.resume()
        //addKidImage()
        testUploadImage()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
