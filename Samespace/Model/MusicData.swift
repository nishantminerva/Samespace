//
//  MusicData.swift
//  Samespace
//
//  Created by Nishant Minerva on 22/10/23.
//

import Foundation


struct MusicData: Codable {
    let data : [Music]
}

class Music: Codable, Identifiable , Equatable {
    static func == (lhs: Music, rhs: Music) -> Bool {
        return lhs.name == rhs.name && lhs.id == rhs.id
    }
    
    let id : Int
    let name: String
    let artist : String
    let accent: String
    let cover: String
    let toptrack: Bool
    let url : String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artist
        case accent
        case cover
        case url
        case toptrack = "top_track"
    }
    
}
