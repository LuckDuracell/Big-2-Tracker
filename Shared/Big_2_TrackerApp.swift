//
//  Big_2_TrackerApp.swift
//  Shared
//
//  Created by Luke Drushell on 5/31/21.
//

import SwiftUI

@main
struct Big_2_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
