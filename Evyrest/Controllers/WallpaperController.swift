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
    
    let cacheDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Caches")
    
    @Published var enabled = false
    @Published var apiSource: ImageSourcing.APISource = .unsplash
    @Published var searchTerm: String = "mountain"
    @Published var savedWallpapers: [URL] = []
    
    var deviceLocked: Bool?
    
    func setup() {
        registerForNotifications()
        
        updateSavedWallpapers()
    }
    
    func stop() {
        // lol
    }
    
    func clearCache() throws {
        try FileManager.default.removeItem(at: cacheDir)
        updateSavedWallpapers()
    }
    
    private func updateSavedWallpapers() {
        // recents in settings
        DispatchQueue.main.async {
            self.savedWallpapers = (try? FileManager.default.contentsOfDirectory(at: self.cacheDir.appendingPathComponent(self.apiSource.rawValue), includingPropertiesForKeys: nil).filter { $0.lastPathComponent != ".DS_Store" /* 💀 */ }) ?? []
        }
    }
    
    private func fetchImageFromCurrentSourceAndCache() async throws -> UIImage {
        if let (fileName, image) = try? await ImageSourcing.getImage(from: apiSource, searchTerm: searchTerm) {
            // there is connection, new random image obtained
            
            let sourceCacheDir = cacheDir.appendingPathComponent(apiSource.rawValue)
            print(sourceCacheDir)
            
            // cache
            try? FileManager.default.createDirectory(at: sourceCacheDir, withIntermediateDirectories: true)
            try? image.pngData()?.write(to: sourceCacheDir.appendingPathComponent(fileName))
            try cleanCacheIfNeeded()
            
            updateSavedWallpapers()
            
            return image
        } else {
            // no internet, use one that's cached
            
            let sourceCacheDir = cacheDir.appendingPathComponent(apiSource.rawValue)
            guard let contents = try? FileManager.default.contentsOfDirectory(at: sourceCacheDir, includingPropertiesForKeys: nil), let randElement = contents.randomElement() else { throw "Couldn't fetch wallpapers from \(apiSource.rawValue) and no images were cached previously" }
            let randomImage = UIImage(contentsOfFile: randElement.path)
            return randomImage!
        }
    }
    
    private func cleanCacheIfNeeded() throws {
        let allSources = ImageSourcing.APISource.allCases
        for source in allSources {
            let sourceCacheDir = cacheDir.appendingPathComponent(source.rawValue)
            
            if source != apiSource {
                // clean other api sources because we no longer need them. can be done better tho
                try? FileManager.default.removeItem(at: sourceCacheDir)
            } else {
                // check if size of active cache folder exceeds the limit
                let contents = (try? FileManager.default.contentsOfDirectory(at: sourceCacheDir, includingPropertiesForKeys: nil)) ?? []
                let cacheLimit = Int(UserDefaults.standard.double(forKey: "cacheLimit"))
                
                if contents.count > cacheLimit {
                    // Remove oldest files
                    let orderedURLs = contents.sorted(by: {
                        if let date1 = try? $0.resourceValues(forKeys: [.addedToDirectoryDateKey]).addedToDirectoryDate,
                           let date2 = try? $1.resourceValues(forKeys: [.addedToDirectoryDateKey]).addedToDirectoryDate {
                            return date1 < date2
                        }
                        return false
                    })
                    print(orderedURLs)
                    let filesToBeDeleted = orderedURLs[0...(contents.count - cacheLimit) - 1]
                    
                    for fileToBeDeleted in filesToBeDeleted {
                        try FileManager.default.removeItem(at: fileToBeDeleted)
                    }
                }
            }
        }
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
                let image = try await fetchImageFromCurrentSourceAndCache()
                WallpaperSetter.shared.setWallpaper(image: image)
            } catch {
                await UIApplication.shared.alert(body: error.localizedDescription)
            }
        }
    }
}
