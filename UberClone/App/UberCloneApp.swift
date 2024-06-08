//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Arman  Urstem on 05.06.2024.
//

import SwiftUI

@main
struct UberCloneApp: App {
    @StateObject var locationViewModel = LocationSearchViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
