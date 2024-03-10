//
//  TipsView.swift
//  Week04
//
//  Created by Yupu Chan on 22/2/2024.
//

import SwiftUI



struct TipsView: View {
    let colors = [Color(#colorLiteral(red: 0.337254902, green: 0.9215686275, blue: 0.8509803922, alpha: 1)), Color(#colorLiteral(red: 0.4858539104, green: 0.7752999663, blue: 0.9617900252, alpha: 1)), Color(.white)]
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Let's Meditate")
                    .font(.system(size: 40, weight: .bold, design: .rounded))

                HStack{
                    Spacer()
                    Text("1. Choose the duration of mindfulness \n2. You can tap on the timer \nto customize the time (in seconds) \n3. Choose your audio \n3. Click START to meditate")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                    Spacer()
                }
                Spacer()
            }

            
        }
    }
}

#Preview {
    TipsView()
}
