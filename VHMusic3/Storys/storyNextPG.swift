//
//  storyNextPG.swift
//  VHMusic3
//
//  Created by Vikas Hareram Shah on 03/02/24.
//

import UIKit

class storyNextPG: UIViewController {
    
    var  selectedStory : storymodel?

    @IBOutlet weak var storytxtView: UITextView!
    @IBOutlet weak var incomestyLBL: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.incomestyLBL.text = selectedStory?.title
        self.storytxtView.text = selectedStory?.description

        
    }
    
    
    
    
    

}
