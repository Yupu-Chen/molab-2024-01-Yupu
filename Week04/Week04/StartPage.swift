//
//  StartPage.swift
//  Week04
//
//  Created by Yupu Chan on 22/2/2024.
//

import SwiftUI

struct StartPage: View {
    let colors = [Color(#colorLiteral(red: 0.337254902, green: 0.9215686275, blue: 0.8509803922, alpha: 1)), Color(#colorLiteral(red: 0.4858539104, green: 0.7752999663, blue: 0.9617900252, alpha: 1)), Color(.white)]
    
    var body: some View {
        NavigationStack{
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    
                    Text("UltraCalm")
                        .font(.system(size: 75, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(#colorLiteral(red: 0.8, green: 0.9215686275, blue: 0.8509803922, alpha: 1)))
                    
                    Spacer()
                    
                    NavigationLink(destination: ContentView(), label: {
                        Text("START")
                    })
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .frame(width: 160, height: 50)
                    .background(Color.green.opacity(0.2))
                    .foregroundStyle(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                }
            }
        }
    }
}

#Preview {
    StartPage()
}
