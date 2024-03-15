//
//  quoteVC.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 27/01/24.
//

import UIKit
import SDWebImage


struct imagemodel : Codable{
    var id : String?
    var image : String?
    var thumb_image : String?
}

struct textmodel : Codable{
    var id : String?
    var  text : String?
}

class CustomLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        return collectionView!.contentOffset  
    }
}

class quoteVC: UIViewController {
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var collectionviewQ: UICollectionView!
    
    var ImageData = [imagemodel]()
    var TextData = [textmodel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionviewQ.register(UINib(nibName: "imagesCVC", bundle: .main), forCellWithReuseIdentifier: "imagesCVC")
        collectionviewQ.register(UINib(nibName: "TextCVC", bundle: .main), forCellWithReuseIdentifier: "TextCVC")
        
        segment.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        imagedata()
        textData()
        
        let layout = CustomLayout()
            collectionviewQ.collectionViewLayout = layout

            
            if segment.selectedSegmentIndex == 0 {
                layout.scrollDirection = .horizontal
            } else {
                layout.scrollDirection = .vertical
            }

       
    }
    
    @objc func segmentedControlValueChanged() {
        if let layout = collectionviewQ.collectionViewLayout as? CustomLayout {
              
               if segment.selectedSegmentIndex == 0 {
                   layout.scrollDirection = .horizontal
               } else {
                   layout.scrollDirection = .vertical
               }
           }

           
           collectionviewQ.reloadData()
       }
    
    func imagedata(){
        guard let urlRequest = URL(string: "https://mapi.trycatchtech.com/v3/motivational_story/motivational_story_image_quotes") else{return}
        let request = URLRequest(url:urlRequest )
        
        URLSession.shared.dataTask(with: request){data,response,error in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do{
                    let jsonData = try JSONDecoder().decode([imagemodel].self,from: data)
                    self.ImageData = jsonData
//                    print(jsonData)
                }catch{
                    print("error in catch block")
                }
                DispatchQueue.main.async {
                    self.collectionviewQ.reloadData()
                }
            }
            
        }.resume()
    }
    func textData(){
        guard let urlRequest = URL(string: "https://mapi.trycatchtech.com/v3/motivational_story/motivational_story_text_quotes") else{return}
        let request = URLRequest(url:urlRequest )
        
        URLSession.shared.dataTask(with: request){data,response,error in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do{
                    let jsonData = try JSONDecoder().decode([textmodel].self,from: data)
                    self.TextData = jsonData
                    print(jsonData)
                }catch{
                    print("error in catch block")
                }
            }
            
        }.resume()
    }
    @IBAction func segment(_ sender: UISegmentedControl) {
        print("seggg \(sender.selectedSegmentIndex)")
        if sender.selectedSegmentIndex == 0 {
            imagedata()
        } else {
            textData()
        }
        
    }
    
}
extension quoteVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return ImageData.count
        }else {
            return TextData.count
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segment.selectedSegmentIndex == 0 {
            let cell = collectionviewQ.dequeueReusableCell(withReuseIdentifier: "imagesCVC", for: indexPath) as! imagesCVC
            let url = URL(string: ImageData[indexPath.row].image ?? "")
            cell.imageQ.sd_setImage(with: url)
            return cell
        } else {
            let cell = collectionviewQ.dequeueReusableCell(withReuseIdentifier: "TextCVC", for: indexPath) as! TextCVC
            cell.textLbl.text = TextData[indexPath.row].text
            
            cell.layer.cornerRadius = 10
            return cell
        }
    }
    

        
}
extension quoteVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if segment.selectedSegmentIndex == 0 {
            return UIEdgeInsets.init(top: 20, left: 30, bottom: 10, right: 10)
        }else{
            return UIEdgeInsets.init(top: 20, left: 10, bottom: 10, right: 10)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

//        let width = collectionviewQ.frame.width - 20
//            return CGSize(width: width, height: width)
//        
        if segment.selectedSegmentIndex == 0 {
                   
            return CGSize(width: collectionView.frame.width / 1.3, height: collectionView.frame.height / 1.2)
                } else {
                   
                    return CGSize(width: collectionView.frame.width / 1.1, height: collectionView.frame.height / 3)
                }
            
    }
    
    
}

