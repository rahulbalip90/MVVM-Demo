//
//  VideoDetailViewModel.swift
//  YouTubeDemo
//
//  Created by JustMac on 28/03/22.
//

import Foundation

struct VideoDetail: Codable {
    let result: DetailResult?
    
    init(){
       result = nil
   }
}

// MARK: - Result
struct DetailResult: Codable {
    let uploadedAt: String
    let thumbnail: DetailThumbnail
    let id: String
    let tags: [String]
    let views: Int
    let type: String
    let ratings: DetailRatings
    let live: Bool
    let title: String
    let resultPrivate: Bool
    let resultDescription: String
    let url: String
    let duration: Int
    let durationFormatted: String
    let channel: DetailChannel

    enum CodingKeys: String, CodingKey {
        case uploadedAt, thumbnail, id, tags, views, type, ratings, live, title
        case resultPrivate = "private"
        case resultDescription = "description"
        case url, duration
        case durationFormatted = "duration_formatted"
        case channel
    }
}

// MARK: - Channel
struct DetailChannel: Codable {
    let name: String
    let icon: String
    let id: String
}

// MARK: - Ratings
struct DetailRatings: Codable {
    let likes, dislikes: Int
}

// MARK: - Thumbnail
struct DetailThumbnail: Codable {
    let url: String
    let height: Int
    let id: String
    let width: Int
}
