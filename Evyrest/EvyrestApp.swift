//
//  EvyrestApp.swift
//  Evyrest
//
//  Created by Toby Fox on 29/11/2022.
//

import SwiftUI
import CoreLocation

@main
struct EvyrestApp: App {
    
    @StateObject var sourceRepoFetcher = SourcedRepoFetcher()
    
    
    @Environment(\.scenePhase) private var phase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sourceRepoFetcher)
        }
    }

    private func setupColorScheme() {
        // We do this via the window so we can access UIKit components too.
        let window = UIApplication.shared.windows.first
        window?.overrideUserInterfaceStyle = .dark
    }
}
