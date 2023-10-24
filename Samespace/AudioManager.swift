//
//  AudioManager.swift
//  Samespace
//
//  Created by Nishant Minerva on 24/10/23.
//

import AVFoundation
import Combine


final class AudioManager {
    static let shared = AudioManager()
    
     var player: AVPlayer?
     var session = AVAudioSession.sharedInstance()
     init() {}
     func activateSession() {
        do {
            try session.setCategory(
                .playback,
                mode: .default,
                options: []
            )
        } catch _ {}
        
        do {
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch _ {}
        
        do {
            try session.overrideOutputAudioPort(.speaker)
        } catch _ {}
    }
    
    func startAudio(songUrl : String) {
            
            // activate our session before playing audio
            activateSession()
            
            // TODO: change the url to whatever audio you want to play
            let url = URL(string: songUrl)
            let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
            if let player = player {
                player.replaceCurrentItem(with: playerItem)
            } else {
                player = AVPlayer(playerItem: playerItem)
            }

            canellable = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
                .sink { [weak self] _ in
                    guard let me = self else { return }
                    
                    me.deactivateSession()
                }
            
            if let player = player {
                player.play()
            }
        }
    
    func deactivateSession() {
        do {
            try session.setActive(false, options: .notifyOthersOnDeactivation)
        } catch let error as NSError {
            print("Failed to deactivate audio session: \(error.localizedDescription)")
        }
    }
    
     var canellable: AnyCancellable?

    deinit {
            canellable?.cancel()
        }

    
    func play() {
            if let player = player {
                player.play()
            }
        }

    func pause() {
            if let player = player {
                player.pause()
            }
        }

    func getPlaybackDuration() -> Double {
            guard let player = player else {
                return 0
            }
         
            return player.currentItem?.duration.seconds ?? 0
        }
}
