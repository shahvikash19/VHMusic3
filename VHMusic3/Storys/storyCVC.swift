//
//  storyCVC.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 02/02/24.
//

import UIKit

class storyCVC: UICollectionViewCell {

    var selectedStory: storymodel?
    
    
    @IBOutlet weak var storylbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func configureCell(with musicModel: storymodel) {
        
        if let title = musicModel.title {
            let components = title.components(separatedBy: "-")
            if let firstPart = components.first {
                storylbl.text = firstPart
            } else {
                storylbl.text = title
            }
        }
    }
   

}
