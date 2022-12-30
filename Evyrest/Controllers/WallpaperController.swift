//
//  WallpaperController.swift
//  Evyrest
//
//  Created by sourcelocation on 29/12/2022.
//

import Foundation
import SwiftUI
import notify


class WallpaperController: ObservableObject {
    
    static let shared = WallpaperController()
    
    @Published var enabled = false
    @Published var apiSource: ImageSourcing.APISource = .unsplash
    @Published var searchTerm: String = "mountain"
    
    var deviceLocked: Bool?
    
    func setup() {
        registerForNotifications()
    }
    
    func stop() {
        // lol
    }
    
    func registerForNotifications() {
        var notify_token: Int32 = 0
        notify_register_dispatch("com.apple.springboard.lockstate", &notify_token, DispatchQueue.main, { token in
            var state: Int64 = 0
            notify_get_state(token, &state)
            
            self.deviceLocked = state == 1
            print(state)
            
            if self.deviceLocked!, self.enabled {
                WallpaperController.shared.updateWallpaper()
            }
        })
    }
    
    func updateWallpaper() {
        Task {
            do {
                let image = try await ImageSourcing.getImage(from: apiSource, searchTerm: "mountain")
                WallpaperSetter.shared.setWallpaper(image: image)
            } catch {
                await UIApplication.shared.alert(body: error.localizedDescription)
            }
        }
    }
}
