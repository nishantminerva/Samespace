//
//  MiniPlayer.swift
//  Samespace
//
//  Created by Nishant Minerva on 23/10/23.
//

import SwiftUI
import AVFoundation

struct MiniPlayer: View {
    var audioManager = AudioManager()
    
    var animation: Namespace.ID
    @Binding var musics: [Music]
    @Binding var expand: Bool
    @Binding var isPlaying : Bool
    @Binding var selectedSongIndex : Int

    var height = UIScreen.main.bounds.height / 3
    
    // Safearea
    var safeArea = UIApplication.shared.windows.first?.safeAreaInsets
    
    // Gesture Offset
    @State var offset: CGFloat = 0
    
        
//    private func timeString(time: TimeInterval) -> String {
//        let minute = Int(time) / 60
//        let seconds = Int(time) % 60
//        return String(format: "%02d:%02d", minute, seconds)
//    }
    
    var body: some View {
            VStack {
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top, expand ? safeArea?.top : 0)
                .padding(.vertical, expand ? 30 : 0)
            
            HStack(spacing: 15) {
                // centering Image
                if expand {
                    Spacer(minLength: 0)
                }
                if expand {
                    ScrollViewReader { value in
                        VStack{
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 16){
                                    ForEach(0..<musics.count, id: \.self){
                                        index in
                                        AsyncImage(url: URL(string: "https://cms.samespace.com/assets/\(musics[index].cover)")!){image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill )
                                                .id(index)
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: height, height: height)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    
                                }
                            }
                            .onAppear{
                                value.scrollTo(selectedSongIndex)
                            }
                        VStack(spacing: 15) {
                            Spacer(minLength: 0)
                            
                            VStack {
                                if expand {
                                    Text(musics[selectedSongIndex].name)
                                        .font(.title2)
                                        .foregroundColor(.primary)
                                        .fontWeight(.bold)
                                        .matchedGeometryEffect(id: "Label", in: animation)
                                    Text(musics[selectedSongIndex].artist)
                                }
                                
                            }
                            .padding()
                            .padding(.top, 20)
                            
                            VStack {
//                                Slider(value: Binding(get: {
//                                    currentTime
//                                }, set: { newValue in
//                                    seekAudio(to: newValue)
//                                }), in: 0...totalTime)
//                                .accentColor(.white)
//
//                                HStack{
//                                    Text(timeString(time: currentTime))
//                                    Spacer()
//                                    Text(timeString(time: totalTime))
//                                }
                            }
                            .padding()
                            
                            // Stop Button
                            HStack{
                                Button(action: {
                                    AudioManager.shared.pause()
                                    if !isPlaying {
                                        isPlaying.toggle()
                                    }
                                    if selectedSongIndex > 0 {
                                        selectedSongIndex -= 1
                                    }
                                    value.scrollTo(selectedSongIndex, anchor: .top)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                        AudioManager.shared.startAudio(songUrl:musics[selectedSongIndex].url)
                                    }
                                }) {
                                    Image(systemName: "backward.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.primary)
                                }
                                Spacer()
                                Button(action: {}) {
                                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.primary)
                                        .onTapGesture {
                                            if isPlaying {
                                                AudioManager.shared.pause()
                                                isPlaying.toggle()
                                            } else {
                                                AudioManager.shared.play()
                                                isPlaying.toggle()
                                            }
                                            
                                        }
                                }
                                Spacer()
                                Button(action: {
                                    AudioManager.shared.pause()
                                    if !isPlaying {
                                        isPlaying.toggle()
                                    }
                                    if selectedSongIndex < musics.count-1 {
                                        selectedSongIndex += 1
                                    }
                                    value.scrollTo(selectedSongIndex, anchor: .top)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                                        AudioManager.shared.startAudio(songUrl:musics[selectedSongIndex].url)
//                                        print(AVPlayer.currentTime(AudioManager.shared.player!))
                                    }

                                }) {
                                    Image(systemName: "forward.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(.primary)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 50)
                            
                            
                            Spacer(minLength: 0)
                            //                .padding()
                                .padding(.bottom, safeArea?.bottom == 0 ? 15 : safeArea?.bottom)
                        }
                        // this will give stretch effect
                        .frame(height: expand ? nil : 0)
                        .opacity(expand ? 1 : 0)
                        
                        
                    }
                        
                    }
                } else {
                    AsyncImage(url: URL(string: "https://cms.samespace.com/assets/\(musics[selectedSongIndex].cover)")!){image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill )
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                if !expand {
                    Text(musics[selectedSongIndex].name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                
                Spacer(minLength: 0)
                
                if !expand {
                    Group{
                        Image(systemName: isPlaying ? "pause.fill": "play.fill")
                            .foregroundColor(.black)
                            .frame(width: 28,height: 28)
                            .onTapGesture {
//                                isPlaying.toggle()
                                if isPlaying {
                                    AudioManager.shared.pause()
                                    isPlaying.toggle()
                                } else {
                                    AudioManager.shared.play()
                                    isPlaying.toggle()
                                }
                            }
                    }
                    .background(.white)
                    .clipShape(
                        Circle()
                    )
                }
            }
            .padding(.horizontal)
            
        }
            // expanding to full screen when clicked
        .frame(maxHeight: expand ? .infinity : 80)
            // moving the miniplayer above the tabBar
            // approx tabBar height is 49
            
            // Divider Line for Separating Miniplayer and TabBar
        .background(
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay(content: {
                    Rectangle()
                        AsyncImage(url: URL(string: "https://cms.samespace.com/assets/\(musics[selectedSongIndex].cover)")!){image in
                            image
                                .resizable()
                                .blur(radius: 55)
                        } placeholder: {
                            ProgressView()
                        }
                    })

                
                Divider()
            }
                .onTapGesture {
                    withAnimation(.spring()) {
                        expand = true
                    }
                }
        )
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : -46)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onEnded(value:)).onChanged(onChanged(value:)))
        .ignoresSafeArea()
        
    }
    
    func onChanged(value: DragGesture.Value) {
        // only allowing when it's expanded
        if value.translation.height > 0 && expand {
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)) {
            // if value is > than height / 3 then closing view
            if value.translation.height > height {
                expand = false
            }
            
            offset = 0
        }
    }
}
//
struct MiniPlayer_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
