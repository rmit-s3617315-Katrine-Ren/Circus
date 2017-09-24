//
//  Image+CoreDataProperties.swift
//  
//
//  Created by MACBOOK on 21/9/17.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var isLike: Bool
    

}
