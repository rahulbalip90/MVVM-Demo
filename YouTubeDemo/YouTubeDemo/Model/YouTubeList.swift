//
//  YouTubeList.swift
//  TouTubeList
//
//  Created by JustMac on 27/03/22.
//

import Foundation


class YouTubeListData: Codable {
    var result: Result?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Result.self, forKey: .result)
    }
    
     init(){
        result = nil
    }
}

// MARK: - Result
class Result: Codable {
    var link: String?
    var id: String?
    var videos: [Video]?
    var videoCount: Int?
    var title: String?
    var views: Int?
    var lastUpdate: String?
    var url: String?
    var channel: Channel?

    enum CodingKeys: String, CodingKey {
        case link, id, videos //thumbnail
        case videoCount = "video_count"
        case title, views
        case lastUpdate = "last_update"
        case url, channel
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        link = try values.decodeIfPresent(String.self, forKey: .link)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        videos = try values.decodeIfPresent([Video].self, forKey: .videos)
        videoCount = try values.decodeIfPresent(Int.self, forKey: .videoCount)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        lastUpdate = try values.decodeIfPresent(String.self, forKey: .lastUpdate)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        channel = try values.decodeIfPresent(Channel.self, forKey: .channel)
        
    }
}

// MARK: - Channel
class Channel: Codable {
    let url: String?
    let name: String?
    let icon: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case name = "Name"
        case icon = "icon"
        case id = "id"
    }
}

// MARK: - Video
class Video: Codable {
    let thumbnail: Thumbnail?
    let id: String?
    let tags: Tags?
    let views: Int?
    let type: TypeEnum?
    let ratings: Ratings?
    let live: Bool?
    let title: String?
    let url: String?
    let duration: Int?
    let durationFormatted: String?

    enum CodingKeys: String, CodingKey {
        case thumbnail, id, tags, views, type, ratings, live, title
        case url, duration
        case durationFormatted = "duration_formatted"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        thumbnail = try values.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        tags = try values.decodeIfPresent(Tags.self, forKey: .tags)
        views = try values.decodeIfPresent(Int.self, forKey: .views)
        type = try values.decodeIfPresent(TypeEnum.self, forKey: .type)

        ratings = try values.decodeIfPresent(Ratings.self, forKey: .ratings)
        live = try values.decodeIfPresent(Bool.self, forKey: .live)
        
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        durationFormatted = try values.decodeIfPresent(String.self, forKey: .durationFormatted)
    }
}

// MARK: - Ratings
class Ratings: Codable {
    let likes, dislikes: Int?
    
    enum CodingKeys: String, CodingKey {
        case likes
        case dislikes
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        dislikes = try values.decodeIfPresent(Int.self, forKey: .dislikes)
    }
}

// MARK: - Tags
struct Tags: Codable {
}

// MARK: - Thumbnail
class Thumbnail: Codable {
    let url: String?
    let height: Int?
    let id: String?
    let width: Int?
    
    enum CodingKeys: String, CodingKey {
        case url
        case height
        case id
        case width
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
    }
}

enum TypeEnum: String, Codable {
    case video = "video"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


class YouTubeSearchData: Codable {
    let results: [Video]?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([Video].self, forKey: .results)
    }
    
     init(){
        results = nil
    }
}
