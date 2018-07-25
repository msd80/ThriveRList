//
//  CommentsViewController.swift
//  RedditList
//
//  Created by Marvin Do on 7/25/18.
//  Copyright © 2018 Marvin Do. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    let comments : UILabel = {
        let commentLabel = UILabel()
        commentLabel.font = UIFont.boldSystemFont(ofSize: 15)
        commentLabel.textColor = UIColor.black
        commentLabel.textAlignment = .left
        commentLabel.translatesAutoresizingMaskIntoConstraints = false
        return commentLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }


}
