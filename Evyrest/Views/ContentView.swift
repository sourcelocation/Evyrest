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
    @ObservedObject var sourc = ImageSourcing.shared
    @AppStorage("enabled") var enabled: Bool = false
    
    @KeychainStorage("userToken") var userToken: String?
    @State var isLoginPresented = false
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            header
            Spacer()
            sourceLocation
            Spacer()
            Spacer()
            Spacer()
            header
            if !enabled {
                Spacer()
            }
            sourceLocation
            if !enabled {
                Spacer()
            }
            button
            footer
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing, content: {
            HStack {
                Spacer()
                Button(action: {
                    UIApplication.shared.alert(title: "Credits", body: "Made by sourcelocation.\n\nYeah, that button is there only for the looks lol")
                }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
        })
        .background(
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 5)
                    .ignoresSafeArea()
                    .opacity(enabled ? 0 : 1)
                    .animation(.spring().speed(0.5), value: enabled)
        )
        .background(Color("BackgroundColor"))
        .popover(isPresented: $isLoginPresented) {
            LoginView()
        }
        .safeAreaInset(edge: .bottom) {
            Text(copyrightLine)
                .foregroundColor(.white)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.top, 2)
        }
        .onAppear {
            isLoginPresented = userToken == nil
        }
    }
    
    @ViewBuilder
    var header: some View {
        Image("Evyrest")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .frame(maxWidth: 175)
            .padding(.top, enabled ? 0 : 64)
            .animation(.spring().speed(1), value: enabled)
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
                                .preferredColorScheme(.light)
                        }
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .animation(.spring().speed(2), value: imageSourcing.apiSource)
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
        .frame(maxWidth: 300, maxHeight: enabled ? 0 : nil)
        .opacity(enabled ? 0 : 1)
        .animation(.spring().speed(2), value: enabled)
    }
    
    @ViewBuilder
    var button: some View {
        Button(action: {
            enabled.toggle()
            
            if enabled {
                
            } else {
                
            }
        }) {
            Image(systemName: enabled ? "checkmark" : "xmark")
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 300)
                .font(.system(size: 16, weight: .black))
        }
        .background(MaterialView(.systemUltraThinMaterialLight).opacity(0.5))
        .cornerRadius(20)
        .animation(.spring(), value: enabled)
    }
    
    @ViewBuilder
    var footer: some View {
        Text(enabled ? "Activated and currently running." : copyrightLine)
            .foregroundColor(.white)
            .font(.footnote)
            .padding(8)
            .animation(.spring().speed(2), value: enabled)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
