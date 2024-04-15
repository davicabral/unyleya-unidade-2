//
//  Issue+CoreDataProperties.swift
//  Unidade3
//
//  Created by Davi Oliveira on 2024-04-14.
//
//

import Foundation
import CoreData


extension Issue {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Issue> {
        let request = NSFetchRequest<Issue>(entityName: "Issue")
        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        request.sortDescriptors = [sort]
        return request
    }

    @NSManaged public var name: String?
    @NSManaged public var location: String?
    @NSManaged public var photo: Data?
    @NSManaged public var explanation: String?
    @NSManaged public var createdAt: Date?

}

extension Issue : Identifiable {

}
