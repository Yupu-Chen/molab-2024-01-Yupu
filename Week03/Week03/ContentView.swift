//
//  ContentView.swift
//  Week03
//
//  Created by Yupu Chan on 6/2/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var dim = 100.0
    
    @State private var bgColor : Color = .black.opacity(0.7)
    
    @State var positions : Array<CGPoint> = [CGPoint(x:50, y:100)]
    
    @State var numCircles : Int? = 0;
    
    
    var body: some View {
        
        VStack {
            
            Section{
                
                ZStack{
                    Rectangle()
                        .fill(bgColor)
                    if self.positions.count != 1 {
                        ForEach(0..<numCircles!, id:\.self){index in
                            Circle()
                                .frame(width:100, height:100)
                                .position(positions[index])
                        }
                    }
                }
            }
            
            Section{
                Button("Generate"){
                    bgColor = Color.random()
                    positions.removeAll()
                    Spawn(of: &positions)
                    numCircles = positions.count
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

func Spawn(of positions: inout Array<CGPoint>) {
    let maxCircls = 20
    positions.removeAll()
    for _ in 0..<Int.random(in: 8...maxCircls) {
        positions.append(CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width), y: CGFloat.random(in: 50...UIScreen.main.bounds.height-240)))
    }
}

#Preview {
    ContentView()
}

extension Color {
    static func random(randomOpacity: Bool = false) -> Color {
            Color(
                red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                opacity: randomOpacity ? .random(in: 0...1) : 1
            )
        }
}
