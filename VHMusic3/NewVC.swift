//
//  NewVC.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 11/02/24.
//

import UIKit

class NewVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func pushBtn(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "quoteVC", bundle: .main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "quoteVC") as! quoteVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
