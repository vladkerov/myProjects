//
//  BMBTechSupportApp.swift
//  BMBTechSupport
//
//  Created by Vlad Kerov on 14.08.2022.
//

import SwiftUI

@main
struct BMBTechSupportApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
