//
//  TweetTableViewCell.swift
//  TwitterClone
//
//  Created by Elizeu RS on 30/06/23.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
  
  static let identifier = "TweetTableViewCell"
  
  private let avatarImageView: UIImageView = {
    
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 25
    imageView.layer.masksToBounds = true
    imageView.clipsToBounds = true
    imageView.image = UIImage(systemName: "person")
    imageView.backgroundColor = .systemRed
    return imageView
  }()
  
  private let displayNameLabel: UILabel = {
    let label = UILabel()
    label.text = "Amr Hossam"
    label.font = .systemFont(ofSize: 18, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let userNameLabel: UILabel = {
    let label = UILabel()
    label.text = "@Amr"
    label.textColor = .secondaryLabel
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let tweetTextContentLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "This is my mockup tweet. it is going to take multiple lines. i believe some more text is enough, but let's add some more anyway... and cheers youtube!!!"
    label.numberOfLines = 0
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(avatarImageView)
    contentView.addSubview(displayNameLabel)
    contentView.addSubview(userNameLabel)
    contentView.addSubview(tweetTextContentLabel)
    configureConstraints()
  }
  
  private func configureConstraints() {
    
    let avatarImageViewConstraints = [
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
      avatarImageView.heightAnchor.constraint(equalToConstant: 50),
      avatarImageView.widthAnchor.constraint(equalToConstant: 50)
    ]
    
    let displayNameLabelConstraints = [
      displayNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
      displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
    ]
    
    let userNameLabelConstraints = [
      userNameLabel.leadingAnchor.constraint(equalTo: displayNameLabel.trailingAnchor, constant: 10),
      userNameLabel.centerYAnchor.constraint(equalTo: displayNameLabel.centerYAnchor),
    ]
    
    let tweetTextContentLabelConstraints = [
      tweetTextContentLabel.leadingAnchor.constraint(equalTo: displayNameLabel.leadingAnchor),
      tweetTextContentLabel.topAnchor.constraint(equalTo: displayNameLabel.bottomAnchor, constant: 10),
      tweetTextContentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      tweetTextContentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
    ]
    
    NSLayoutConstraint.activate(avatarImageViewConstraints)
    NSLayoutConstraint.activate(displayNameLabelConstraints)
    NSLayoutConstraint.activate(userNameLabelConstraints)
    NSLayoutConstraint.activate(tweetTextContentLabelConstraints)

    
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

}
