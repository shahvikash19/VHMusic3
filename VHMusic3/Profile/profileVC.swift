//
//  profileVC.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 27/01/24.
//

import UIKit
import CoreData


struct userData : Codable{
    var Email : String = ""
    var Name : String = ""
}

var userdata = [Login].self

class profileVC: UIViewController {

    @IBOutlet weak var lgBTN: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!

    var appDelegate: AppDelegate {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        return appDelegate
    }

    var userData = [Login]() {
        didSet {

        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(userData)
        fetchData()
        self.lgBTN.layer.cornerRadius = 20
    }

    @IBAction func loginBTN(_ sender: Any) {
        guard let username = usernameTF.text, !username.isEmpty else { return }
        guard let password = passwordTF.text, !password.isEmpty else { return }

        let context = appDelegate.persistentContainer.viewContext
        let userDetails = Login(context: context)
        userDetails.userame = username
        userDetails.password = password

        print("userDetails...\(userDetails)")
        
        
        appDelegate.saveContext()
        userData.append(userDetails)

        usernameTF.text = ""
        passwordTF.text = ""
    }

    func fetchData() {
        let context = appDelegate.persistentContainer.viewContext

        do {
            userData = try context.fetch(Login.fetchRequest()) as! [Login]
            print(userData.count)
        } catch {
            print("error -: \(error)")
        }
    }
    
    
}
