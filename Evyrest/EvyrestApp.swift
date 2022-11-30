//
//  EvyrestApp.swift
//  Evyrest
//
//  Created by Toby Fox on 29/11/2022.
//

import SwiftUI

@main
struct EvyrestApp: App {
    
    @StateObject var sourceRepoFetcher = SourcedRepoFetcher()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sourceRepoFetcher)
                .preferredColorScheme(.dark)
        }
    }
}
