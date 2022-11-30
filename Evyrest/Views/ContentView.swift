//
//  ContentView.swift
//  Evyrest
//
//  Created by Toby Fox on 29/11/2022.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var imageSourcing = ImageSourcing(apiSource: .pexels)
    @AppStorage("userToken") var userToken: String?
    
    var body: some View {
        ZStack {
            VStack {
                Image("Evyrest")
                    .resizable()
                    .frame(width: 120.0, height: 120.0)
                    .padding(.bottom, 40.0)
                
                ZStack {
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
//                                    .background(.thinMaterial.opacity(imageSourcing.apiSource == sourceType ? 0.25 : 0))
//                                    .cornerRadius(100)
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
                }
                .background(.ultraThinMaterial.opacity(0.5))
                .cornerRadius(20)
                .frame(maxWidth: 300)
            }
            Spacer()
        }
        .background(
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .blur(radius: 5)
                .scaleEffect(1.1)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
