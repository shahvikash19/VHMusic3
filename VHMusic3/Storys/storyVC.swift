//
//  storyVC.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 02/02/24.
//

import UIKit


struct storymodel : Codable{
    var id : String?
    var title : String?
    var description : String?
}

class storyVC: UIViewController {
    
    var Storydata = [storymodel]()
    var searchData = [storymodel]()
    var isFilterinf = false
    @IBOutlet weak var searchview: UIView!
    @IBOutlet weak var searchbarS: UISearchBar!
    @IBOutlet weak var collectionviewS: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionviewS.register(UINib(nibName: "storyCVC", bundle: .main), forCellWithReuseIdentifier: "storyCVC")
        storydata()
        self.searchbarS.layer.cornerRadius = 10
        self.searchview.layer.cornerRadius = 20
        
    }
    
    func storydata(){
        guard let urlRequest = URL(string: "https://mapi.trycatchtech.com/v3/motivational_story/motivational_story_stories") else{return}
        let request = URLRequest(url:urlRequest )
        
        URLSession.shared.dataTask(with: request){data,response,error in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do{
                    let jsonData = try JSONDecoder().decode([storymodel].self,from: data)
                    self.Storydata = jsonData
//                    print(jsonData)
                }catch{
                    print("error in catch block")
                }
                DispatchQueue.main.async {
                    self.collectionviewS.reloadData()
                }
            }
            
        }.resume()
    }
 
    


}
extension storyVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = searchbarS.text?.isEmpty == false ?  searchData.count : Storydata.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionviewS.dequeueReusableCell(withReuseIdentifier: "storyCVC", for: indexPath) as! storyCVC
        
        let data: storymodel

        if searchbarS.text?.isEmpty == false {
            data = searchData[indexPath.row]
        } else {
            data = Storydata[indexPath.row]
        }
        cell.storylbl.text = Storydata[indexPath.row].title
        cell.configureCell(with: data)
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedStory: storymodel
        if searchbarS.text?.isEmpty == false {
            selectedStory = searchData[indexPath.row]
        } else {
            selectedStory = Storydata[indexPath.row]
        }
        let storyboard = UIStoryboard(name: "storyNextPG", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "storyNextPG") as! storyNextPG
       vc.selectedStory = Storydata[indexPath.row]
        vc.selectedStory = selectedStory
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension storyVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width-30)/2)
        let height = width / 2.5
        return CGSize(width: width, height: height)
    }
    func updateCollectionView(for searchText: String) {
            if searchText.isEmpty {
                searchData = Storydata
            } else {
                searchData = Storydata.filter { $0.title?.lowercased().contains(searchText.lowercased()) ?? false }
            }
            collectionviewS.reloadData()
    }
}
extension storyVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        filterContentForSearchText("")
        collectionviewS.reloadData()
        storydata()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        searchData = Storydata.filter { (music) -> Bool in
            return music.title?.lowercased().contains(searchText.lowercased()) ?? false
        }
        //        if searchText.isEmpty {
        //            searchData = Storydata
        //        }
        //        else{
        //            searchData = Storydata.filter
        //            {
        //                $0.title?.range(of: searchText, options: .caseInsensitive) != nil
        //            }
        //        }
                collectionviewS.reloadData()
        //    }
    }
}
