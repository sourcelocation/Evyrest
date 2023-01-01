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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var sourceRepoFetcher = SourcedRepoFetcher()
    
    let locationManager = LocationManager()
    
    @Environment(\.scenePhase) private var phase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(sourceRepoFetcher)
                .onAppear {
                    UserDefaults.standard.register(
                        defaults: [
                            "downloadOnCellular": false,
                            "changeHomeScreen": true,
                            "changeLockScreen": true
                        ]
                    )
                    ApplicationMonitor.shared.start()
                }
        }
    }

    private func setupColorScheme() {
        // We do this via the window so we can access UIKit components too.
        let window = UIApplication.shared.windows.first
        window?.overrideUserInterfaceStyle = .dark
    }
}
