//
//  UpdateCommentsVC.swift
//  rndm
//
//  Created by Ivan Toskov on 25.09.18.
//  Copyright © 2018 Ivan Toskov. All rights reserved.
//

import UIKit
import Firebase

class UpdateCommentsVC: UIViewController {

    // Outlets
    @IBOutlet weak var commentTxt: UITextView!
    @IBOutlet weak var updateBtn: UIButton!
    
    // Variables
    var commentData : (comment: Comment, thought: Thought)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTxt.layer.cornerRadius = 10
        updateBtn.layer.cornerRadius = 10
        commentTxt.text = commentData.comment.commentTxt
    }

    @IBAction func updatePressed(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.documentId).collection(COMMENTS_REF).document(commentData.comment.documentId).updateData([COMMENT_TXT : commentTxt.text]) { (error) in
            if let error = error {
                debugPrint("Unable to update comment: \(error.localizedDescription)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
    }
}
}
