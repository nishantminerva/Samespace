//
//  ContentView.swift
//  Samespace
//
//  Created by Nishant Minerva on 22/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var musics = [Music]()
    
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
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
            .onAppear() {
                Task {
                    await loadData()
                }
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
