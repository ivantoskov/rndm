//
//  AddThoughtVC.swift
//  rndm
//
//  Created by Ivan Toskov on 17.09.18.
//  Copyright © 2018 Ivan Toskov. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {

    // Outlets
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var thoughtText: UITextView!
    @IBOutlet private weak var postBtn: UIButton!
    
    // Variables
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postBtn.layer.cornerRadius = 4
        thoughtText.layer.cornerRadius = 4
        thoughtText.text = "My random thought..."
        thoughtText.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        thoughtText.delegate = self
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            THOUGHT_TXT : thoughtText.text,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : Auth.auth().currentUser?.displayName ?? "", 
            USER_ID : Auth.auth().currentUser?.uid ?? ""
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding document: \(err.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
}
