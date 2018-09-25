//
//  UpdateThoughtVC.swift
//  rndm
//
//  Created by Ivan Toskov on 25.09.18.
//  Copyright © 2018 Ivan Toskov. All rights reserved.
//

import UIKit
import Firebase

class UpdateThoughtVC: UIViewController {

    // Outlets
    @IBOutlet weak var categorySegment: UISegmentedControl!
    @IBOutlet weak var thoughtTxt: UITextView!
    @IBOutlet weak var updateBtn: UIButton!
    
    // Variables
    var thought: Thought!
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thoughtTxt.layer.cornerRadius = 4
        updateBtn.layer.cornerRadius = 4
        thoughtTxt.text = thought.thoughtTxt
        
    }
    
    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
    
    @IBAction func updatePressed(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId).updateData([THOUGHT_TXT : thoughtTxt.text,
                                                                                                CATEGORY : selectedCategory]) { (error) in
            if let error = error {
                debugPrint("Error updating thought: \(error.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
