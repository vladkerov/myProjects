//
//  UpdateOperation.swift
//  BMBTechSupport
//
//  Created by Vlad Kerov on 20.08.2022.
//

import Foundation
import CoreData

struct UpdateOperation<Object: NSManagedObject>: Identifiable {
    let id = UUID()
    let childContext: NSManagedObjectContext
    let childObject: Object
    
    init?(
        withExistingObject object: Object,
        in parentContext: NSManagedObjectContext
    ) {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = parentContext
        guard let childObject = try? childContext.existingObject(with: object.objectID) as? Object else { return nil }
        
        self.childContext = childContext
        self.childObject = childObject
    }
}
