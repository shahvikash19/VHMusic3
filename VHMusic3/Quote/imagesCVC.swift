//
//  imagesCVC.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 27/01/24.
//

import UIKit

class imagesCVC: UICollectionViewCell {

    @IBOutlet weak var shareBTN: UIButton!
    @IBOutlet weak var likeBTN: UIButton!
    @IBOutlet weak var imageQ: UIImageView!
    
    var imageURL: String?
    var isLiked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shareBTN.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        likeBTN.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        imageQ.layer.cornerRadius = 10
        
        
    }
    @objc func shareButtonTapped() {
            guard let image = imageQ.image else {
                print("No image to share.")
                return
            }

            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            let viewController = UIApplication.shared.windows.first?.rootViewController
            viewController?.present(activityViewController, animated: true, completion: nil)
        }

//        @objc func likeButtonTapped() {
//            // Handle the like button action here
//            // You can implement the logic to toggle the like state, update UI, etc.
//            print("Like button tapped.")
//        }
//    
    @objc func likeButtonTapped() {
           
            isLiked.toggle()

            
            let likeButtonImage = isLiked ? UIImage(named: "ic_fav") : UIImage(named: "ic_fav_selected")
            likeBTN.setImage(likeButtonImage, for: .normal)

            
        }

}
