//
//  OptionsView.swift
//  Evyrest
//
//  Created by sourcelocation on 30/12/2022.
//

import SwiftUI
import Photos

struct OptionsView: View {
    @ObservedObject var wallpaperController = WallpaperController.shared
    
    @State private var presentAlert = false
    
    struct RecentWallpaperView: View {
        @State var action: () -> ()
        @State var url: URL
        
        var body: some View {
            Button(action: action) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 70, height: 140)
                        .clipped()
                        .overlay(alignment: .bottom) {
                            Image(systemName: "arrow.down")
                                .padding(4)
                                .frame(maxWidth: .infinity)
                                .background {
                                    MaterialView(.dark)
                                        .frame(height: 32)
                                        .opacity(0.5)
                                }
                        }
                        .cornerRadius(8)
                    
                } placeholder: {
                    Color.gray
                        .frame(width: 70)
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                presentAlert = true
            }) {
                ZStack {
                    Image("Background2")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 80)
                        .clipped()
                    Color(hex: "00213A")
                        .opacity(0.3)
                        .clipped()
                    VStack {
                        Text("Current theme")
                            .font(.footnote)
                            .foregroundColor(.white)
                        Text(wallpaperController.searchTerm)
                            .font(.headline)
                    }
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: "chevron.right")
                        .padding(8)
                }
                .cornerRadius(8)
                .frame(height: 80)
            }
            .padding(.horizontal)
            .padding(.top)
            
            VStack(spacing: 8) {
                HStack {
                    Text("Recents")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        try? wallpaperController.clearCache()
                    }) {
                        Image(systemName: "xmark.bin.fill")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                            .background(MaterialView(.light))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                if wallpaperController.savedWallpapers.isEmpty {
                    ZStack {
                        MaterialView(.light)
                            .frame(height: 48)
                            .cornerRadius(12)
                            .padding()
                        Text("Recent wallpapers will appear here.")
                            .font(.footnote)
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(Array(wallpaperController.savedWallpapers.enumerated()), id: \.1) { (n, wallpaper) in
                                let isFirst = n == 0 // make sure these are valid or the styling wont work
                                let isLast = n == wallpaperController.savedWallpapers.count - 1
                                
                                let egg: () -> Void = {
                                    PHPhotoLibrary.shared().performChanges({
                                        PHAssetChangeRequest.creationRequestForAsset(from: UIImage(contentsOfFile: wallpaper.path)!)
                                    })
                                }
                                
                                RecentWallpaperView(action: egg, url: wallpaper)
                                    .padding(.leading, isFirst ? 16 : 0)
                                    .padding(.trailing, isLast ? 16 : 0)
                            }
                        }
                    }
                    .frame(height: 140)
                }
            }
            
            VStack {
                HStack {
                    Text("Cache limit")
                        .font(.headline)
                    Spacer()
                    Text(wallpaperController.cacheLimit != 150 ? "\(Int(wallpaperController.cacheLimit))" : "∞")
                    Image(systemName: "photo.on.rectangle.angled")
                }
                .padding(.horizontal)
                
                Slider(value: $wallpaperController.cacheLimit, in: 0...150)
                    .tint(.init("BackgroundColor"))
                    .padding(.horizontal)
            }
            
            VStack {
                Toggle(isOn: $wallpaperController.changeLockScreen) {
                    Text("Lock screen")
                    //                        .font(.headline)
                }
                Toggle(isOn: $wallpaperController.changeHomeScreen) {
                    Text("Home screen")
                    //                        .font(.headline)
                }
                Toggle(isOn: $wallpaperController.downloadOnCellular) {
                    Text("Download on Cellular")
                    //                        .font(.headline)
                }
            }
            .padding(.horizontal)
            .tint(.init("BackgroundColor"))
            .padding(.bottom)
        }
        .foregroundColor(.white)
        .textFieldAlert(isPresented: $presentAlert) { () -> TextFieldAlert in
            TextFieldAlert(title: "Set theme", message: "Enter any search query to be used for fetching from Unsplash. Keep them simple and using one word", text: Binding<String?>($wallpaperController.searchTerm))
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(optionsPresented: true)
    }
}
