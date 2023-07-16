//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Elizeu RS on 29/06/23.
//

import UIKit
import FirebaseAuth
import Combine

class HomeViewController: UIViewController {
  
  private var viewModel = HomeViewViewModel()
  private var subscriptions: Set<AnyCancellable>  = []
  
  // chance let to lazy var - so we can access navigateToTweetComposer() from here.
  private lazy var composeTweetButton: UIButton = {
    let button = UIButton(type: .system, primaryAction: UIAction { [weak self] _ in
      self?.navigateToTweetComposer()
//      print("Tweet is being prepared")
    })
    
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .twitterBlueColor
    button.tintColor = .white
    let plusSign = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold))
    button.setImage(plusSign, for: .normal)
    button.layer.cornerRadius = 30
    button.clipsToBounds = true
    return button
  }()
  
  private func configureNavigationBar() {
    let size: CGFloat = 30
    let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
    logoImageView.contentMode = .scaleToFill
    logoImageView.image = UIImage(named: "twitterLogo")
    
    let middleView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
    middleView.addSubview(logoImageView)
    navigationItem.titleView = middleView
    
    let profileImage = UIImage(systemName: "person")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(didTapProfile))
  }
  
  @objc private func didTapProfile() {
    let vc = ProfileViewController()
    navigationController?.pushViewController(vc, animated: true)
//    print("pressed profile")
  }
  
  private let timelineTableView: UITableView = {
    let tableView = UITableView()
    tableView.register(TweetTableViewCell.self,
                       forCellReuseIdentifier: TweetTableViewCell.identifier)
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(timelineTableView)
    view.addSubview(composeTweetButton)
    timelineTableView.delegate = self
    timelineTableView.dataSource = self
    configureNavigationBar()
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(didTapSignOut))
    bindViews()
  }
  
  @objc private func didTapSignOut() {
    try? Auth.auth().signOut()
    handleAuthentication()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    timelineTableView.frame = view.frame
    configureConstraints()
  }
  
  private func handleAuthentication() {
    if Auth.auth().currentUser == nil {
      let vc = UINavigationController(rootViewController: OnboardingViewController())
      vc.modalPresentationStyle = .fullScreen
      present(vc, animated: true)
    }
  }
  
  private func navigateToTweetComposer() {
    let vc = UINavigationController(rootViewController: TweetComposeViewController())
    vc.modalPresentationStyle = .fullScreen
    present(vc, animated: false)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
    handleAuthentication()
    viewModel.retrieveUser()
  }
  
  func completeUserOnboarding() {
    let vc = ProfileDataFormViewController()
    present(vc, animated: true)
  }
  
  func bindViews() {
    viewModel.$user.sink { [weak self] user in
      guard let user = user else { return }
      if !user.isUserOnboarded  {
        self?.completeUserOnboarding()
      }
    }
    .store(in: &subscriptions)
  }
  
  private func configureConstraints() {
    let composeTweetButtonConstraints = [
      composeTweetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
      composeTweetButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
      composeTweetButton.widthAnchor.constraint(equalToConstant: 60),
      composeTweetButton.heightAnchor.constraint(equalToConstant: 60),
    ]
    
    NSLayoutConstraint.activate(composeTweetButtonConstraints)
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

