//
//  MainContent.swift
//  Week04
//
//  Created by Yupu Chan on 19/2/2024.
//

import SwiftUI
import AVFoundation

// from sample code

let players = [
    loadBundleAudio("rain.mp3"),
    loadBundleAudio("forest.mp3"),
    loadBundleAudio("cave.mp3")
]

let icons = [
    "cloud.rain",
    "tree",
    "moon.stars"
]

func loadBundleAudio(_ fileName:String) -> AVAudioPlayer? {
    let path = Bundle.main.path(forResource: fileName, ofType:nil)!
    let url = URL(fileURLWithPath: path)
    do {
        return try AVAudioPlayer(contentsOf: url)
    } catch {
        print("loadBundleAudio error", error)
    }
    return nil
}

struct MainContent: View {
    let colors = [Color(#colorLiteral(red: 0.337254902, green: 0.9215686275, blue: 0.8509803922, alpha: 1)), Color(#colorLiteral(red: 0.4858539104, green: 0.7752999663, blue: 0.9617900252, alpha: 1)), Color(.white)]
    
    // this will help display the time as Minute:Seconds
    let durations = [5 * 60, 10 * 60, 15 * 60, 20 * 60]
    
    //for count down
    @State private var countDown : Int = 5 * 60
    @State private var currentTimer : Int = 5 * 60
    @State private var running = false
    @State private var custom = false
    
    //for player
    @State private var player: AVAudioPlayer? = players[0]
    
    @FocusState private var focused : Bool
    
    // from sample code given in class
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack{
                ZStack {
                    LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                    VStack{
                        if !running && !custom{
                            NavigationLink(destination: TipsView(), label: {Image(systemName: "questionmark.app")})
                                .padding(.leading, (geo.size.width*3/4))
                        }

                        Spacer()
                        if !running && !custom{
                            HStack{
                                Spacer(minLength: geo.size.width/20)
                                withAnimation{
                                    Picker("", selection: $countDown) {
                                        ForEach(durations, id:\.self) {duration in
                                            Text("\(duration/60) Min")
                                        }
                                    }
                                    .onChange(of: countDown) {
                                        player?.currentTime = .zero
                                        currentTimer = countDown
                                    }
                                }
                                .pickerStyle(.segmented)
                                Spacer(minLength: geo.size.width/20)
                            }
                        }
                        // display the time
                        if !custom {
                            Text(String(format:"%02i:%02i", currentTimer/60, currentTimer % 60))
                                .font(.system(size: 120, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                                .onTapGesture {
                                    if !running {
                                        withAnimation{
                                            custom = true
                                            focused = true
                                        }
                                    }
                                }
                        } else {
                            TextField("Custom", value: $countDown, format: .number)
                                .keyboardType(.decimalPad)
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .focused($focused)
                                .toolbar{
                                    ToolbarItemGroup(placement: .keyboard)
                                    {
                                        Spacer()
                                        Button(action: {
                                            focused = false
                                            custom = false
                                        }){
                                            Text("Done")
                                        }
                                    }
                                }
                                .onChange(of: countDown) {
                                    player?.currentTime = .zero
                                    currentTimer = countDown
                                }
                        }
                        
                        if !custom {
                            Button(action: {
                                withAnimation { // make the transition smoother
                                    self.running.toggle()
                                    player?.numberOfLoops = -1
                                    if !player!.isPlaying {
                                        print("play")
                                        print("\(player?.currentTime ?? 10000)")
                                        player?.play()
                                    } else {
                                        print("paused")
                                        player?.pause()
                                    }
                                }
                            }) {Text(running ? "PAUSE" : "START")
                                    .frame(width: 160, height:60)
                                    .font(.system(size:30, weight:.medium, design:.rounded))
                                    .background(Color.black.opacity(0.45))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        Spacer()
                        
                        HStack{
                            if !running && !custom {
                                Spacer(minLength: geo.size.width/20)
                                Picker("Music", selection: $player) {
                                    ForEach (players, id:\.self){ player in
                                        Image(systemName: icons[players.firstIndex(of: player)!])
                                    }
                                }
                                .pickerStyle(.segmented)
                                .onChange(of: player) {
                                    currentTimer = countDown
                                }
                                Spacer(minLength: geo.size.width/20)
                            }
                        }
                        .onReceive(timer, perform: { _ in
                            if currentTimer > 0 && running
                            {
                                currentTimer -= 1
                            } else if currentTimer == 0
                            {
                                player?.setVolume(0.0, fadeDuration: 1) //music fade out
                            }
                        })
                    }
                }
            }
        }
    }
}


#Preview {
    MainContent()
}
