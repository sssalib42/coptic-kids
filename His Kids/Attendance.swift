//
//  OneAttendanceRecordTableViewController.swift
//  His Kids
//
//  Created by Saher  Salib on 9/26/16.
//  Copyright © 2016 Samer Salib. All rights reserved.
//

import UIKit

class Attendance: UITableViewController {

    
    var values: NSArray = []
    var classroomID = 3;
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getKids()
        tableView.allowsMultipleSelection = true;
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func saveAttendance(_ sender: AnyObject) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return values.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCell", for: indexPath)
        let mainData = values[(indexPath as NSIndexPath).row] as? NSDictionary
        
        if (count < values.count){
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            cell.accessoryType = .checkmark
            count += 1
        }
        if(cell.isSelected){
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        let firstName = mainData?["firstName"] as? String
        let lastName = mainData?["lastName"] as? String
        let name = firstName! + " " + lastName!
        
        cell.textLabel?.text = name
        //cell.detailTextLabel!.text = mainData["dob"] as? String
        //cell.address.text = mainData?["email"] as? String
        //cell.phone.text = mainData?["phone"] as? String
        
        
        return cell;
    }
//    
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCell", for: indexPath)
//        cell.accessoryType = .checkmark
//        cell.isSelected = true
//        return indexPath
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = tableView.cellForRow(at: indexPath)
        selectedRow?.accessoryType = .checkmark
        //selectedRow?.tintColor = UIColor.green
//        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCell", for: indexPath)
//        if (cell.accessoryType == .checkmark){
//            
//        }
//        else{
//            self.workAround = tableView.indexPathsForSelectedRows!
//            tableView.beginUpdates()
//            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//            tableView.endUpdates()
//            tableView.deselectRow(at: indexPath, animated: false)
//        {
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedRow = tableView.cellForRow(at: indexPath)
        selectedRow?.accessoryType = .none
        //selectedRow?.tintColor = UIColor.red
        //self.workAround = tableView.indexPathsForSelectedRows!
        //tableView.beginUpdates()
        //tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        //tableView.endUpdates()
//        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCell", for: indexPath)
//        cell.accessoryType = .none
//        cell.isSelected = true
//        
////        tableView.beginUpdates()
//        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
////        tableView.endUpdates()
    }
    
    
    func getKids(){
        var request = URLRequest(url: URL(string: "http://coptdevs.org/LittleOnes/classroomKids.php")!)
        request.httpMethod = "POST"
        let postString = "classroomID=\(classroomID)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSDictionary
                self.values = (json["kids"] as? NSArray)!
                
            }
            catch let error as NSError{
                print(error)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    @IBAction func Save(_ sender: AnyObject) {
        var present = false
        var attendanceStr = ""
        
        if let selected = tableView.indexPathsForSelectedRows{
            for i in (0..<values.count){
                present = false
                for j in (0..<selected.count){
                    if selected[j].row == i{
                        present = true
                        break
                    }
                }
                if present{
                    let mainData = values[i] as? NSDictionary
                    let temp = mainData?["id"] as! NSNumber
                    attendanceStr += String(describing: temp) + "++,"
                    print("AttendanceStr is now: \(attendanceStr)")
                }
                else{
                    let mainData = values[i] as? NSDictionary
                    let temp = mainData?["id"] as! NSNumber
                    attendanceStr += String(describing: temp) + "--,"
                    print("AttendanceStr is now: \(attendanceStr)")
                }
            }
            attendanceStr = attendanceStr.substring(to: attendanceStr.index(before: attendanceStr.endIndex))
        }
        sendAttendance(attendanceStr: attendanceStr)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Cancel(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func sendAttendance(attendanceStr: String?){
        let myUrl = URL(string: "http://coptdevs.org/LittleOnes/addAttendance.php");

        let request = NSMutableURLRequest(url:myUrl!);
        request.httpMethod = "POST";

        request.httpMethod = "POST"
        var postString = "classroomID=\(classroomID)"
        if let attendance = attendanceStr {
            postString += "&attendance=\(attendance)"
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {(
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
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
