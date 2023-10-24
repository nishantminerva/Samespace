//
//  Home.swift
//  Samespace
//
//  Created by Nishant Minerva on 22/10/23.
//

import SwiftUI
//import AVFoundation
//import AVFAudio

//class SoundManager : ObservableObject {
//    var audioPlayer: AVPlayer?
//
//    func playSound(sound: String){
//        if let url = URL(string: sound) {
//            self.audioPlayer = AVPlayer(url: url)
//        }
//    }
//
//    func stopSound() {
//            self.audioPlayer?.pause()
//            self.audioPlayer = nil
//        }
//}


struct Home: View {
    @State private var isPlaying : Bool = false
    @State private var selectedSongIndex: Int = 0
    @State private var showMiniPlayer = false
    @State private var musics = [Music]()
    @Namespace private var animation
    func loadData() async {
        guard let url = URL(string: "https://cms.samespace.com/items/songs") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(MusicData.self, from: data) {
                musics = decodedResponse.data
            }
        } catch {
            print("Invalid data")
        }
    }

    @State private var activeTab: Tab = .foryou
//    For Smooth Shape Sliding Effect, we're going to use Matched Geometry Effect
   
    @State private var tabShapePosition: CGPoint = .zero
    
    // Miniplayer Properties
    @State var expand = false
    
    init(){
//        Hiding tab Bar Due to SwiftUI IOS 16 Bug
        UITabBar.appearance().isHidden = true
    }
    
    
    var body: some View {
        // Bottom Mini Player
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                TabView(selection: $activeTab){
                    ForYouView(selectedIndexSong: $selectedSongIndex, musics: $musics, isPlaying: $isPlaying, showMiniPlayer: $showMiniPlayer)
                        .tag(Tab.foryou)
                    
                    
                    TopTrackView(selectedIndexSong: $selectedSongIndex, musics: $musics, isPlaying: $isPlaying, showMiniPlayer: $showMiniPlayer)
                        .tag(Tab.toptrack)
                    
                }
                .onAppear() {
                    Task {
                        await loadData()
                    }
                }

            CustomTabBar(activeTab: $activeTab)
                .background{
                    Rectangle()
                        .foregroundColor(.black)
//                        .mask(gradient)
//                            .opacity(0.9)
                        .blur(radius: 5)
                        .ignoresSafeArea()
                }
   
            }
            .overlay(alignment: .bottom){
                if showMiniPlayer {
                    MiniPlayer(animation: animation, musics: $musics, expand: $expand, isPlaying: $isPlaying, selectedSongIndex: $selectedSongIndex)
                }
            }
        
    }
    
}
