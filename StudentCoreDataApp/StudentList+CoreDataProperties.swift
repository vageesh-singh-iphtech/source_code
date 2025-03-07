//
//  StudentList+CoreDataProperties.swift
//  StudentCoreDataApp
//
//  Created by iPHTech 35 on 06/03/25.
//
//

import Foundation
import CoreData


extension StudentList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentList> {
        return NSFetchRequest<StudentList>(entityName: "StudentList")
    }

    @NSManaged public var name: String?
    @NSManaged public var rollno: String?
    @NSManaged public var department: String?
    @NSManaged public var address: String?

}

extension StudentList : Identifiable {

}
