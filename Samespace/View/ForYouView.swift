//
//  ForYouView.swift
//  Samespace
//
//  Created by Nishant Minerva on 22/10/23.
//


import SwiftUI


struct ForYouView: View {
    @Binding var selectedIndexSong : Int
    @Binding var musics: [Music]
    @Binding var isPlaying: Bool
    @Binding var showMiniPlayer: Bool
    
    var body: some View {
        List{
            ForEach(0..<musics.count, id: \.self) {index in
                ExtractedView(musics: musics, selectedIndexSong: $selectedIndexSong ,song: .constant(musics[index]), isPlaying: $isPlaying, showMiniPlayer: $showMiniPlayer)
                    .listRowBackground(Color.black)
                    .listRowSeparator(.hidden)
            }
                
            }

    }
}


struct ExtractedView: View {
    @State var musics: [Music]
    @Binding var selectedIndexSong : Int
    @Binding var song: Music
    @Binding var isPlaying: Bool
    @Binding var showMiniPlayer: Bool
    
    var audioManager = AudioManager()
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://cms.samespace.com/assets/\(song.cover)")!){image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill )
                    .clipShape(Circle())
                    .frame(width: 48, height: 48)
                
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading){
                Text(song.name)
                    .font(.title3)
                    .foregroundColor(.white)
                Text(song.artist)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .onTapGesture {
            selectedIndexSong = musics.firstIndex(of: song)!
            isPlaying.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                showMiniPlayer = true
            }
            AudioManager.shared.pause()
            if isPlaying{
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    AudioManager.shared.startAudio(songUrl:musics[selectedIndexSong].url)
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    AudioManager.shared.startAudio(songUrl:musics[selectedIndexSong].url)
                }
                isPlaying.toggle()
            }
        }
    }
}
