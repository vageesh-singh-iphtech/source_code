//
//  StuRecords+CoreDataProperties.swift
//  StudentUsingCoreData
//
//  Created by iPHTech 35 on 05/03/25.
//
//

import Foundation
import CoreData


extension StuRecords {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StuRecords> {
        return NSFetchRequest<StuRecords>(entityName: "StuRecords")
    }

    @NSManaged public var stuName: String?
    @NSManaged public var stuRollno: String?
    @NSManaged public var stuDepartment: String?
    @NSManaged public var stuAddress: String?

}

extension StuRecords : Identifiable {

}
