//
//  TextCVC.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 27/01/24.
//

import UIKit

class TextCVC: UICollectionViewCell {
    var isLiked = false

    @IBOutlet weak var sharetxtBTN: UIButton!
    @IBOutlet weak var favtxtBTN: UIButton!
    @IBOutlet weak var textLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        textLbl.layer.cornerRadius = 10
        sharetxtBTN.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        favtxtBTN.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
        
    }
    @objc func shareButtonTapped() {
            guard let textToShare = textLbl.text else {
                print("No text to share.")
                return
            }

            let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
            let viewController = UIApplication.shared.windows.first?.rootViewController
            viewController?.present(activityViewController, animated: true, completion: nil)
        }
    @objc func likeButtonTapped() {
           
            isLiked.toggle()
            let likeButtonText = isLiked ? UIImage(named: "icons8-heart-24(@1×) 1") : UIImage(named: "icons8-heart-24(@1×)")
            favtxtBTN.setImage(likeButtonText, for: .normal)

            
        }

   
   

}
