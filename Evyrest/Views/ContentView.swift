//
//  ContentView.swift
//  Evyrest
//
//  Created by Toby Fox on 29/11/2022.
//

import SwiftUI
import CoreMotion



struct ContentView: View {
    
    @ObservedObject var wallpaperController = WallpaperController.shared
    
    @AppStorage("userToken") var userToken: String?
    @State var loginPresented = false
    
    @State var optionsPresented = false
    @State var aboutPresented = false
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                Image("Background")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 5)
                
                    .opacity(wallpaperController.enabled ? 0 : 1)
                    .scaleEffect(wallpaperController.enabled ? 1.1 : 1)
                    .scaleEffect(optionsPresented || aboutPresented ? 0.95 : 1)
                    .animation(.spring().speed(0.5), value: wallpaperController.enabled)
                    .animation(.spring(), value: aboutPresented)
                    .animation(.spring(), value: optionsPresented)
                    .parallaxed(magnitude: 1.2)
                VStack {
                    Spacer()
                    header
                    if !wallpaperController.enabled {
                        Spacer()
                    }
                    sourceLocation
                    if !wallpaperController.enabled {
                        Spacer()
                        Spacer()
                    }
                    button
                    footer
                    if wallpaperController.enabled {
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .sheet(isPresented: $loginPresented, content: {LoginView()})
                .onAppear {
                    wallpaperController.setup()
                #if targetEnvironment(simulator) || DEBUG
                #else
                    loginPresented = userToken == nil
                #endif
                }
                .blur(radius: optionsPresented || aboutPresented ? 2 : 0)
                .scaleEffect(optionsPresented || aboutPresented ? 0.85 : 1)
                .animation(.spring(), value: optionsPresented)
                .animation(.spring(), value: aboutPresented)
                
                Color.black
                    .ignoresSafeArea()
                    .opacity(optionsPresented || aboutPresented ? 0.5 : 0)
                    .animation(.spring(), value: optionsPresented)
                    .animation(.spring(), value: aboutPresented)
                    .onTapGesture {
                        if optionsPresented {
                            optionsPresented = false
                        }
                        if aboutPresented {
                            aboutPresented = false
                        }
                    }
                // MARK: - Options & About
                ZStack {
                    AboutView()
                        .opacity(aboutPresented ? 1 : 0)
                    OptionsView()
                        .opacity(optionsPresented ? 1 : 0)
                }
                .frame(maxWidth: 300)
                .background(MaterialView(.light)
                    .opacity(0.8)
                    .cornerRadius(20))
                .scaleEffect(optionsPresented || aboutPresented ? 1 : 0.9)
                .opacity(optionsPresented || aboutPresented ? 1 : 0)
                .animation(.spring().speed(1.5), value: optionsPresented)
                .animation(.spring().speed(1.5), value: aboutPresented)
            }
        }
        
    }
    
    @ViewBuilder
    var header: some View {
        Image("Evyrest")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .frame(maxWidth: 175)
            .scaleEffect(wallpaperController.enabled ? 1.15 : 1)
            .animation(.spring().speed(1), value: wallpaperController.enabled)
    }
    
    @ViewBuilder
    var sourceLocation: some View {
        VStack {
            ForEach(ImageSourcing.APISource.allCases, id: \.rawValue) { sourceType in
                VStack {
                    Button {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        wallpaperController.apiSource = sourceType
                    } label: {
                        HStack {
                            Image(sourceType.rawValue)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.trailing, 20.0)
                                .frame(height: 32)
                            Text(sourceType.rawValue)
                                .foregroundColor(Color.white)
                                .padding(.trailing, 20.0)
                            Spacer()
                            Image(systemName: wallpaperController.apiSource == sourceType ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            //                                            .foregroundColor(.accentColor)
                                .frame(height: 22)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.white, Color.accentColor)
                                .opacity(wallpaperController.apiSource == sourceType ? 1 : 0.25)
                                .preferredColorScheme(.light)
                        }
                        .padding(.vertical, 6)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .animation(.spring().speed(2), value: wallpaperController.apiSource)
                        .background(Color(red: 1, green: 1, blue: 1, opacity: 0.00001))
                    }
                    .buttonStyle(.plain)
                    if ImageSourcing.APISource.allCases.last! != sourceType {
                        Divider()
                            .background(.white)
                            .opacity(0.5)
                    }
                }
            }
        }
        .padding()
        .background(MaterialView(.systemUltraThinMaterialLight).opacity(0.5))
        .cornerRadius(20)
        .frame(maxWidth: 300, maxHeight: wallpaperController.enabled ? 0 : nil)
        .opacity(wallpaperController.enabled ? 0 : 1)
        .animation(.spring().speed(2), value: wallpaperController.enabled)
    }
    
    @ViewBuilder
    var button: some View {
        HStack(spacing:0) {
            
            // MARK: - Bottom row buttons
            
            Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                //                UIApplication.shared.alert(title: "Credits", body: "Made by sourcelocation (with a bit of help from llsc12).\n\nMIT - Skittyblock/WallpaperSetter\nPublic Domain - rileytestut/Clip \n\nIdea - FreshWall by SparkDev")
                aboutPresented.toggle()
            }) {
                Image(systemName: "info.circle")
                    .foregroundColor(.white)
                    .padding()
                    .font(.system(size: 16, weight: .bold))
            }
            .background(MaterialView(.systemUltraThinMaterialLight).opacity(0.5))
            .cornerRadius(32)
            .opacity(wallpaperController.enabled ? 0 : 1)
            .animation(.spring(), value: wallpaperController.enabled)
            .padding(.trailing, 12)
            .frame(maxWidth: wallpaperController.enabled ? 0 : nil)
            
            
            Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                wallpaperController.enabled.toggle()
            }) {
                Image(systemName: wallpaperController.enabled ? "checkmark" : "xmark")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 300)
                    .font(.system(size: 16, weight: .bold))
            }
            .background(MaterialView(.systemUltraThinMaterialLight).opacity(0.5))
            .cornerRadius(32)
            .animation(.spring(), value: wallpaperController.enabled)
            
            Button(action: {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                optionsPresented.toggle()
            }) {
                Image(systemName: "switch.2")
                    .foregroundColor(.white)
                    .padding()
                    .font(.system(size: 16, weight: .black))
            }
            .background(MaterialView(.systemUltraThinMaterialLight).opacity(0.5))
            .cornerRadius(32)
            .opacity(wallpaperController.enabled ? 0 : 1)
            .animation(.spring(), value: wallpaperController.enabled)
            .padding(.leading, 12)
            .frame(maxWidth: wallpaperController.enabled ? 0 : nil)
        }
        .frame(maxWidth: 300)
    }
    
    @ViewBuilder
    var footer: some View {
        VStack(spacing: 0) {
            Text(wallpaperController.enabled ? "Enabled and currently running." : "© 2022 sourcelocation with ♡")
            
                .foregroundColor(.white)
                .font(.footnote)
                .padding(.top, 8)
                .padding(.bottom, wallpaperController.enabled ? 4 : 10)
                .animation(.spring().speed(1), value: wallpaperController.enabled)
                .multilineTextAlignment(.center)
            
            Text("Try locking your device.")
                .foregroundColor(.init(hex: "#AAA"))
                .font(.footnote)
                .frame(maxHeight: wallpaperController.enabled ? nil : 0)
                .opacity(wallpaperController.enabled ? 1 : 0)
                .animation(.spring().speed(1), value: wallpaperController.enabled)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
