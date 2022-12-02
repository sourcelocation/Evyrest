//
//  ContentView.swift
//  Evyrest
//
//  Created by Toby Fox on 29/11/2022.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    @ObservedObject var imageSourcing = ImageSourcing.shared
    @KeychainStorage("userToken") var userToken: String?
    @AppStorage("enabled") var enabled: Bool = false
    
    var body: some View {
        VStack {
            header
            Spacer()
            sourceLocation
            Spacer()
            Spacer()
            Spacer()
            button
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing, content: {
            Text("gn")
        })
        .background {
            Image("Background")
                .resizable()
                .scaledToFill()
                .blur(radius: 5)
                .ignoresSafeArea()
                .parallaxed(magnitude: 1.5)
        }
        .background(Color("BackgroundColor"))
        .safeAreaInset(edge: .bottom) {
            Text(copyrightLine)
                .foregroundColor(.white)
                .font(.footnote)
        }
    }
    
    @ViewBuilder
    var header: some View {
        Image("Evyrest")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .frame(maxWidth: 175)
            .padding(.top, 64)
    }
    
    @ViewBuilder
    var sourceLocation: some View {
        VStack {
            ForEach(ImageSourcing.APISource.allCases, id: \.rawValue) { sourceType in
                VStack {
                    Button {
                        imageSourcing.apiSource = sourceType
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
                            Image(systemName: imageSourcing.apiSource == sourceType ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            //                                            .foregroundColor(.accentColor)
                                .frame(height: 22)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.white, Color.accentColor)
                                .opacity(imageSourcing.apiSource == sourceType ? 1 : 0.25)
                        }
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .animation(.spring().speed(2), value: imageSourcing.apiSource)
                    }
                    .buttonStyle(.plain)
                    if ImageSourcing.APISource.allCases.last! != sourceType {
                        Divider()
                            .background(.white)
                    }
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial.opacity(0.5))
        .cornerRadius(20)
        .frame(maxWidth: 300)
    }
    
    @ViewBuilder
    var button: some View {
        Button(action: {
            enabled.toggle()
        }) {
            Image(systemName: enabled ? "checkmark" : "xmark")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 300)
                .font(.system(size: 16, weight: .black))
        }
        .background(Material.ultraThinMaterial.opacity(enabled ? 0.5 : 0.3))
        .cornerRadius(20)
        .animation(.spring().speed(2), value: enabled)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
