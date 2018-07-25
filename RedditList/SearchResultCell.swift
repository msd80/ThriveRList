//
//  SearchResultCell.swift
//  RedditList
//
//  Created by Marvin Do on 7/24/18.
//  Copyright © 2018 Marvin Do. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    //MARK:- Variable/Fields
    var searchResult : SearchResult? {
        didSet {
            title.text = searchResult?.title
            thumbnail.image = searchResult?.thumbnail
        }
    }
    
    private let thumbnail : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private let title : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(thumbnail)
        addSubview(title)
        
        // Fix this later
        thumbnail.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        title.anchor(top: topAnchor, left: thumbnail.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
