//
//  TopTrackView.swift
//  Samespace
//
//  Created by Nishant Minerva on 22/10/23.
//


import SwiftUI

struct TopTrackView: View {
    @Binding var selectedIndexSong : Int
    @Binding var musics : [Music]
    @Binding var isPlaying: Bool
    @Binding var showMiniPlayer: Bool
    
    var body: some View {
        List{
            ForEach(0..<musics.count, id: \.self) {index in
                if(musics[index].toptrack){
                    ExtractedView(musics: musics, selectedIndexSong: $selectedIndexSong ,song: .constant(musics[index]), isPlaying: $isPlaying, showMiniPlayer: $showMiniPlayer)
                        .listRowBackground(Color.black)
                        .listRowSeparator(.hidden)}
                    }
            }
        }

    }



