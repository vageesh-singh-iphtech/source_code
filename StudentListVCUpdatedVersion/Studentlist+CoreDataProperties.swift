//
//  Studentlist+CoreDataProperties.swift
//  StudentListVCUpdatedVersion
//
//  Created by iPHTech 35 on 05/03/25.
//
//

import Foundation
import CoreData


extension Studentlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Studentlist> {
        return NSFetchRequest<Studentlist>(entityName: "Studentlist")
    }

    @NSManaged public var studName: String?
    @NSManaged public var rollNo: String?
    @NSManaged public var stuDept: String?
    @NSManaged public var stuAddress: String?

}

extension Studentlist : Identifiable {

}
