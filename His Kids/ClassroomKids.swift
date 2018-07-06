//
//  Kids.swift
//  His Kids
//
//  Created by Saher  Salib on 9/13/16.
//  Copyright © 2016 Samer Salib. All rights reserved.
//

import UIKit

class ClassroomKids: UITableViewController {

    @IBOutlet var kidsTableView: UITableView!
    @IBOutlet weak var kidsTableViewCell: UITableViewCell!
    @IBOutlet weak var addKid: UIBarButtonItem!
    @IBOutlet weak var classroomTitleNavBar: UINavigationItem!
    @IBOutlet weak var addKidButton: UIBarButtonItem!
    
    
    
    var values: NSArray = []
    var classroomID = 3;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "3rd Grade"
        getKids();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getKids()
    }
    
    func getKids(){
        var request = URLRequest(url: URL(string: "http://coptdevs.org/SundaySchool/getServableList.php")!)
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
                self.values = (json["servableList"] as? NSArray)!
                
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return values.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classroomKidsCell", for: indexPath)
        
        let mainData = values[(indexPath as NSIndexPath).row] as? NSDictionary
        let firstName = mainData?["firstName"] as? String
        let lastName = mainData?["lastName"] as? String
        let name = firstName! + " " + lastName!
        
        print("the name is d", name)
        cell.textLabel!.text = name
        //cell.detailTextLabel!.text = mainData["dob"] as? String
        //cell.address.text = mainData?["email"] as? String
        //cell.phone.text = mainData?["phone"] as? String
        
        return cell;
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
