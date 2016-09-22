//
//  File.swift
//  His Kids
//
//  Created by Saher  Salib on 9/12/16.
//  Copyright © 2016 Samer Salib. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class Address: NSManagedObject {
    
    @NSManaged var apartment: String?
    @NSManaged var city: String?
    @NSManaged var id: NSNumber?
    @NSManaged var state: String?
    @NSManaged var streetName: String?
    @NSManaged var streetNumber: String?
    @NSManaged var zip: String?
    
    convenience init(apartment: String, city: String, id: NSNumber, state: String, streetName: String, streetNumber: String, zip: String, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!)
    {
        self.init(entity: entity, insertInto: context)
        
        self.apartment = apartment
        self.city = city
        self.id = id
        self.state = state
        self.streetName = streetName
        self.streetNumber = streetNumber
        self.zip = zip
    }
    
}

class AttendanceRecord: NSManagedObject {
    
    @NSManaged var classroomID: NSNumber?
    @NSManaged var date: String?
    @NSManaged var kidsIDs: String?
    
}

class Church: NSManagedObject {
    
    @NSManaged var addressID: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    
}

class Classroom: NSManagedObject {
    
    @NSManaged var churchID: NSNumber?
    @NSManaged var grade: String?
    @NSManaged var id: NSNumber?
    @NSManaged var location: String?
    @NSManaged var name: String?
    @NSManaged var year: String?
    
}

class Image: NSManagedObject {
    
    @NSManaged var id: NSNumber?
    @NSManaged var image: NSObject?
    
}

class Parent: NSManagedObject {
    
    @NSManaged var kidID: NSNumber?
    @NSManaged var personID: NSNumber?
    
}

class Person: NSManagedObject {
    
    @NSManaged var addressID: NSNumber?
    @NSManaged var dob: String?
    @NSManaged var email: String?
    @NSManaged var firstName: String?
    @NSManaged var id: NSNumber?
    @NSManaged var imageID: NSNumber?
    @NSManaged var lastName: String?
    @NSManaged var phone: String?
    
    
    
    convenience init(addressID: NSNumber, dob: String, email: String, firstName: String, id: NSNumber, imageID: NSNumber, lastName: String, phone: String, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!)
    {
        self.init(entity: entity, insertInto: context)
        
        self.addressID = addressID
        self.dob = dob
        self.email = email
        self.firstName = firstName
        self.id = id
        self.imageID = imageID
        self.lastName = lastName
        self.phone = phone
    }

}

class Priest: NSManagedObject {
    
    @NSManaged var chruchID: String?
    @NSManaged var servantID: String?
    
}

class Servant: NSManagedObject {
    
    @NSManaged var classroomID: NSNumber?
    @NSManaged var coordinationLevel: NSNumber?
    @NSManaged var servantID: NSNumber?
    
}
