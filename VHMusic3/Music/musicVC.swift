//
//  musicVC.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 27/01/24.
//

import UIKit
import AVKit

struct musicmodel : Codable{
    var id : String?
    var title : String?
    var file : String?
    
   
}



class musicVC: UIViewController {
  
    var Musicdata = [musicmodel]()
    var searchdata = [musicmodel]()
    var isFiltering = false
    @IBOutlet weak var musicView: UIView!
    @IBOutlet weak var searchMs: UISearchBar!
    @IBOutlet weak var collectionviewM: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionviewM.register(UINib(nibName: "musicCVC", bundle: .main), forCellWithReuseIdentifier: "musicCVC")
       
        musicdata()
        searchMs.delegate = self
        self.searchMs.layer.cornerRadius = 10
        self.musicView.layer.cornerRadius = 20
    }
        
    func musicdata(){
        guard let urlRequest = URL(string: "https://mapi.trycatchtech.com/v3/motivational_story/motivational_story_music") else{return}
        let request = URLRequest(url:urlRequest )
        
        URLSession.shared.dataTask(with: request){data,response,error in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do{
                    let jsonData = try JSONDecoder().decode([musicmodel].self,from: data)
                    self.Musicdata = jsonData
//                    print(jsonData)
                }catch{
                    print("error in catch block")
                }
                DispatchQueue.main.async {
                    self.collectionviewM.reloadData()
                }
            }
            
        }.resume()
    }
   
 
}
extension musicVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = searchMs.text?.isEmpty == false ?  searchdata.count : Musicdata.count
        return count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionviewM.dequeueReusableCell(withReuseIdentifier: "musicCVC", for: indexPath) as! musicCVC
        let data: musicmodel
//        if isFiltering {
//            data = searchdata[indexPath.row]
//        }else{
//            data = Musicdata[indexPath.row]
//        }

        if searchMs.text?.isEmpty == false {
            data = searchdata[indexPath.row]
        } else {
            data = Musicdata[indexPath.row]
        }
//        if let firstMusic = Musicdata.first {
//            print(firstMusic.title)
//        }
        cell.musicLBL.text = /*Musicdata[indexPath.row].title*/data.title
        cell.configureCell(with: data)
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedMusic = Musicdata[indexPath.row]
//            performSegue(withIdentifier: "showDetailsSegue", sender: selectedMusic)
        let selectedMusic: musicmodel
            if searchMs.text?.isEmpty == false {
                selectedMusic = searchdata[indexPath.row]
            } else {
                selectedMusic = Musicdata[indexPath.row]
            }
        print("Selected music title: \(selectedMusic.title ?? "N/A")")
        print("Selected music file URL: \(selectedMusic.file ?? "N/A")")
        let storyboard = UIStoryboard(name: "musicnxtPG", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "musicnxtPG") as! musicnxtPG
       vc.selectedmusic = Musicdata[indexPath.row]
        vc.selectedmusic = selectedMusic
        self.navigationController?.pushViewController(vc, animated: true)
        }
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetailsSegue" {
//            if let destinationVC = segue.destination as? MusicDetailsViewController,
//               let selectedMusic = sender as? musicmodel {
//                destinationVC.selectedMusic = selectedMusic
//            }
//        }
//    }
}
extension musicVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width-60)/2)
        let height = width / 2.5
        return CGSize(width: width, height: height)
    }
}
extension musicVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filterContentForSearchText("")
        collectionviewM.reloadData()
        musicdata()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        searchdata = Musicdata.filter { (music) -> Bool in
            return music.title?.lowercased().contains(searchText.lowercased()) ?? false
        }
        //        if searchText.isEmpty {
        //            searchdata = Musicdata
        //        }
        //        else{
        //            searchdata = Musicdata.filter
        //            {
        //                $0.title?.range(of: searchText, options: .caseInsensitive) != nil
        //            }
        //        }
                collectionviewM.reloadData()
        //    }
    }
}
