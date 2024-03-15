//
//  ViewController.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 27/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextbtn(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "onbording")
        UserDefaults.standard.synchronize()
        let storyboard = UIStoryboard(name: "quoteVC", bundle: .main)
        if let vc = storyboard.instantiateViewController(identifier: "quoteVC") as? quoteVC {
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Error: Unable to instantiate 'quoteVC' from the storyboard.")
        }
    }
}

