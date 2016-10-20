//
//  AttendanceRecordsTableViewController.swift
//  His Kids
//
//  Created by Saher  Salib on 9/26/16.
//  Copyright © 2016 Samer Salib. All rights reserved.
//

import UIKit

class AttendanceRecords: UITableViewController {

    var dateFormatter: DateFormatter!;
    var date: Date!;
    var classroomID = 3;
    var values: NSArray! = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAttendanceRecords()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @IBAction func done(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceRecordsCell", for: indexPath)
        
        let mainData = values[(indexPath as NSIndexPath).row] as? NSDictionary
        let dateStr = mainData?["date"] as? String
        
//        dateFormatter!.dateFormat! = "yyyy-mm-dd"
//        date = dateFormatter.date(from: dateStr!)!
//        dateFormatter.dateFormat = "DD-MMM-YYYY"
//        
//        print("the date is: ", date)
//        print("The fromatted date is: ", dateFormatter.string(from: date))
//        cell.textLabel!.text = dateFormatter.string(from: date)

        
        print("the date is: ", dateStr)
        cell.textLabel!.text = dateStr
        
        return cell;
    }
    
    func getAttendanceRecords(){
        var request = URLRequest(url: URL(string: "http://coptdevs.org/LittleOnes/attendanceRecords.php")!)
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
                self.values = (json["AttendanceRecords"] as? NSArray)!
                
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
