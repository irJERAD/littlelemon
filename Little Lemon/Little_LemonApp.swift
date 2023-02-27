//
//  Little_LemonApp.swift
//  Little Lemon
//
//  Created by Jerad Acosta on 2/27/23.
//

import SwiftUI

@main
struct Little_LemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
