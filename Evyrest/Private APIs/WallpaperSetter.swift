//
//  WallpaperSetter.swift
//  Evyrest
//
//  Created by sourcelocation on 27/12/2022.
//

// with the help of https://github.com/MichaelMKenny/ios-13-light-dark-wallpaper-app

import UIKit
import Dynamic

func frameworkPath(framework: String) -> String {
    var path: String!
    #if targetEnvironment(simulator)
        path = "/Applications/Xcode-14.2.0.app/Contents/Developer/Platforms/iPhoneOS.platform/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS.simruntime/Contents/Resources/RuntimeRoot/System/Library/PrivateFrameworks/"
    #else
        path = "/System/Library/PrivateFrameworks/"
    #endif
    return path + framework
}

func loadPrivateFramework(_ name: String) {
    Bundle(path: frameworkPath(framework: name))!.load()
}


class WallpaperSetter {
    static var shared = WallpaperSetter()
    
    typealias SBSUIWallpaperSetImagesFunction = (@convention(c) (_: NSDictionary, _: NSDictionary, _: Int, _: Int) -> Int)
    /// 1. dict of images for light and dark,
    /// 2. dict of options for light and dark,
    /// 3. location (1=lock, 2=home, 3=both),
    /// 4. who knows what the last option is

    
    func setWallpaper(image: UIImage, homescreen: Bool, lockscreen: Bool) {
        loadPrivateFramework("SpringBoardFoundation.framework");
        
        let optionsLight = Dynamic.SBFWallpaperOptions()
        optionsLight.setWallpaperMode(1)
        optionsLight.setName("1234.Wallpaper Light")
        optionsLight.setParallaxFactor(1)
        
        let optionsDark = Dynamic.SBFWallpaperOptions()
        optionsDark.setWallpaperMode(1)
        optionsDark.setName("1234.Wallpaper Dark")
        optionsDark.setParallaxFactor(1)
        
        let sbui = dlopen(frameworkPath(framework: "SpringBoardUIServices.framework") + "/SpringBoardUIServices", RTLD_LAZY)
        defer {
            dlclose(sbui)
        }
        
        let symbolPointer = dlsym(sbui, "SBSUIWallpaperSetImages")!
        let SBSUIWallpaperSetImages = unsafeBitCast(
            symbolPointer,
            to: SBSUIWallpaperSetImagesFunction.self
        )
        let result = SBSUIWallpaperSetImages(
            NSDictionary(dictionary: ["light": image, "dark": image]),
            NSDictionary(dictionary: ["light": optionsLight.asAnyObject!, "dark": optionsDark.asAnyObject!]),
            homescreen ? (lockscreen ? 3 : 2) : (lockscreen ? 1 : 0),
            UIUserInterfaceStyle.dark.rawValue
        )
    }
}
