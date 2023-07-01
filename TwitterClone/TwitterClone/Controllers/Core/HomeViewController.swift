//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Elizeu RS on 29/06/23.
//

import UIKit

class HomeViewController: UIViewController {
  
  private let timelineTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(TweetTableViewCell.self,
                       forCellReuseIdentifier: TweetTableViewCell.identifier)
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(timelineTableView)
    timelineTableView.delegate = self
    timelineTableView.dataSource = self
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    timelineTableView.frame = view.frame
  }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath) as? TweetTableViewCell else { return UITableViewCell()
    }
    
    cell.delegate = self
    return cell
    
    /*
     let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "Tweet"
    return cell
     */
  }
  
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return 120
//  }
}

extension HomeViewController: TweetTableViewCellDelegate {
  func tweetTableViewCellDidTapReply() {
    print("Reply")
  }
  
  func tweetTableViewCellDidTapRetweet() {
    print("Retweet")
  }
  
  func tweetTableViewCellDidTapLike() {
    print("Like")
  }
  
  func tweetTableViewCellDidTapShare() {
    print("Share")
  }
}

