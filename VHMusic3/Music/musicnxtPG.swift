//
//  musicnxtPG.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 04/02/24.
//

import UIKit
import AVKit

class musicnxtPG: UIViewController {
    
    var selectedmusic: musicmodel?
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var isPlaying = false
    var isLiked = false

    @IBOutlet weak var playbtn: UIButton!
    @IBOutlet weak var MusicShareBtn: UIButton!
    @IBOutlet weak var likebtn: UIButton!
    @IBOutlet weak var sliderMUbtn: UISlider!
    @IBOutlet weak var displylbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        if let selectedMusic = selectedmusic {
//                    print("Playing music: \(selectedMusic.title ?? "N/A"), File URL: \(selectedMusic.file ?? "N/A")")
//                    // Add code to play the music using the selectedMusic.title and selectedMusic.file
//                }
        self.displylbl.text = selectedmusic?.title
        print("Selected music in musicnxtPG: \(selectedmusic?.title ?? "N/A")")
        likebtn.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        MusicShareBtn.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        setupPlayer()
        sliderMUbtn.value = 0.0
        
        
    }
    
    @objc func shareButtonTapped() {
        guard let musicFile = selectedmusic?.file, let musicURL = URL(string: musicFile) else {
               print("Invalid URL for music file.")
               return
            }

            let activityViewController = UIActivityViewController(activityItems: [musicFile], applicationActivities: nil)
            let viewController = UIApplication.shared.windows.first?.rootViewController
            viewController?.present(activityViewController, animated: true, completion: nil)
        }
    @objc func likeButtonTapped() {
           
            isLiked.toggle()

            let likeButtonMusic = isLiked ? UIImage(named: "ic_fav") : UIImage(named: "ic_fav_selected")
        likebtn.setImage(likeButtonMusic, for: .normal)
     
        }
  
    func setupPlayer() {
        guard let musicFile = selectedmusic?.file, let musicURL = URL(string: musicFile) else {
            print("Invalid URL for music file.")
            return
        }

        player = AVPlayer(url: musicURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = CGRect(x: 0, y: 0, width: 10, height: 10) // Set the frame as needed
        view.layer.addSublayer(playerLayer!)

        
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let duration = self?.player?.currentItem?.duration.seconds else { return }
            let currentTime = time.seconds
            self?.updateSliderPosition(currentTime: currentTime, duration: duration)
        }
    }

    func updateSliderPosition(currentTime: Double, duration: Double) {
        sliderMUbtn.value = Float(currentTime / duration)
    }

    @IBAction func playBTN(_ sender: UIButton) {
        
        if isPlaying {
               player?.pause()
           } else {
               player?.play()
           }
           isPlaying.toggle()
           
        let systemImageName = isPlaying ? "pause.circle.fill" : "play.circle"
            let playButtonImage = UIImage(systemName: systemImageName)
            playbtn.setImage(playButtonImage, for: .normal)
    }

    deinit {
            
        if let timeObserver = player?.currentItem?.observationInfo {
                player?.removeTimeObserver(timeObserver)
            }
        
        }
    @IBAction func backMubtn(_ sender: UIButton) {
        if let currentTime = player?.currentTime() {
               let newTime = max(currentTime.seconds - 10, 0)
               player?.seek(to: CMTime(seconds: newTime, preferredTimescale: 1))
           }
    }
    
    
    @IBAction func forwordMUbtn(_ sender: UIButton) {
        if let currentTime = player?.currentTime(), let duration = player?.currentItem?.duration.seconds {
                let newTime = min(currentTime.seconds + 10, duration)
                player?.seek(to: CMTime(seconds: newTime, preferredTimescale: 1))
            }
    }
}
