//
//  musicCVC.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 02/02/24.
//

import UIKit
import AVKit

class musicCVC: UICollectionViewCell {
    
    var  selectedmusic : musicmodel?
    
    @IBOutlet weak var musicLBL: UILabel!
    @IBOutlet weak var musicBTN: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func playBTN(_ sender: UIButton) {
        
    }
    
        func configureCell(with musicModel: musicmodel) {
            
            if let title = musicModel.title {
                let components = title.components(separatedBy: "-")
                if let firstPart = components.first {
                    musicLBL.text = firstPart
                } else {
                    musicLBL.text  = title
                }
            }
        }
    }
    
    
    
    

