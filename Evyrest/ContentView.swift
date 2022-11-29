//
//  ContentView.swift
//  Evyrest
//
//  Created by Toby Fox on 29/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State var pexels = false
    @State var unsplash = false
    @State var microsoft = false
    @State var local = false
    
    var body: some View {
        ZStack {
                VStack{
                    Image("Evyrest")
                        .resizable()
                        .frame(width: 120.0, height: 120.0)
                        .padding(.bottom, 40.0)
                    
                    ZStack{
                        VStack{
                            Button{
                                pexels = true
                            }label:{
                                HStack{
                                    Image("Pexels").resizable().aspectRatio(contentMode: .fit).padding(.trailing, 20.0)
                                    Text("Pexels")
                                        .foregroundColor(Color.white)
                                        .padding(.trailing, 20.0)
                                    Image(systemName:"circle") .foregroundColor(Color.white)
                                }
                            }.frame(height: 40.0)
                        }
                        
                }.frame(width: 300.0, height: 250.0)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).opacity(0.3))
            }
            Spacer()
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
