//
//  ViewController.swift
//  RedditList
//
//  Created by Marvin Do on 7/24/18.
//  Copyright © 2018 Marvin Do. All rights reserved.
//

import UIKit
import SwiftyJSON

class RedditListTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Variables/Outlets
    private var redditTableView : UITableView!
    var json : JSON = [] {
        didSet {
            DispatchQueue.main.async {
                self.redditTableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        initRedditTableView()
        getJSONFromReddit()
        print(json)
        
    }
    
    //MARK:- Private Functions
    func getJSONFromReddit() {
        let urlString = "http://www.reddit.com/r/all/new.json?limit=25"
        let url = URL(string: urlString)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.showNetworkError()
            } else {
                let json = SwiftyJSON.JSON(data)
                self.json = json
            }
        }
        task.resume()
        self.redditTableView.reloadData()
    }
    
    func showNetworkError() {
        let alert = UIAlertController(title: "Reddit Listing Error",
                                      message: "There was an error." +
            " Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    // Create Custom Reddit Table View and set self as delegate
    func initRedditTableView() {
        let yValue : CGFloat = UIApplication.shared.statusBarFrame.size.height
        let tableWidth : CGFloat = self.view.frame.width
        let tableHeight : CGFloat = self.view.frame.height
        redditTableView = UITableView(frame: CGRect(x: 0,
                                                    y: yValue,
                                                    width: tableWidth,
                                                    height: tableHeight))
        redditTableView.delegate = self
        redditTableView.dataSource = self
        redditTableView.register(SearchResultCell.self, forCellReuseIdentifier: CellIdentifiers.searchResultCell)
        self.view.addSubview(redditTableView)
    }

    //MARK:- Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        //return json["data"]["children"].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = redditTableView.dequeueReusableCell(withIdentifier: CellIdentifiers.searchResultCell,
                                                       for: indexPath) as! SearchResultCell
        let rawTitleString = json["data"]["children"][indexPath.row]["data"]["title"].rawString()
        let thumbnailJSON = json["data"]["children"][indexPath.row]["data"]["thumbnail"].rawString()
        if thumbnailJSON == "default" || thumbnailJSON == "self" {
            cell.searchResult = SearchResult(title: rawTitleString, thumbnail: UIImage(named: "CloseButton"))
        } else {
                // Fix this
            cell.searchResult = SearchResult(title: rawTitleString, thumbnail: UIImage(named: "CloseButton"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print(json["data"]["children"][indexPath.row]["data"]["title"])
        let commentsVC = CommentsViewController(nibName: "CommentsViewController", bundle: nil)
        navigationController?.pushViewController(commentsVC, animated: true)
        
    }
    

    //MARK:- TableView Cell Identifiers
    struct CellIdentifiers {
        static let searchResultCell = "SearchResultCell"
     //   static let emptyResultCell = "EmptyResultCell"
    }
}

