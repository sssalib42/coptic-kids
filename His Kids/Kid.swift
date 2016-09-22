//
//  Kid.swift
//  His Kids
//
//  Created by Saher  Salib on 9/12/16.
//  Copyright © 2016 Samer Salib. All rights reserved.
//

import UIKit

class Kid: UITableViewCell {

   // @IBOutlet weak var kidImage: UIImageView!
    //@IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    //@IBOutlet weak var dob: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dob: UILabel!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
