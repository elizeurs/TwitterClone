//
//  Tweet.swift
//  TwitterClone
//
//  Created by Elizeu RS on 16/07/23.
//

import Foundation

struct Tweet: Codable {
  var id = UUID().uuidString
  let author: TwitterUser
  let authorID: String
  let tweetContent: String
  let likeCount: Int
  let likers: [String]
  let isReply: Bool
  let parentReference: String?
}
