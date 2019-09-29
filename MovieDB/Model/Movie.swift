//
//  Movie.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation

class Movie: Codable {
    
    var voteCount: Int = 0
    var id: Int = 0
    var video: Bool = false
    var voteAverage: Float = 0.0
    var title: String = ""
    var popularity: Float = 0.0
    var posterPath: String = ""
    var originalLanguage: String = ""
    var originalTitle: String = ""
    var genreIds: [Int] = []
    var backdropPath: String = ""
    var adult: Bool = false
    var overview: String = ""
    var releaseDate: String = ""
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id
        case video
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
    }
    
    var fullPosterPath: String {
        return "\(Constant.MOVIE_DB_IMAGE_BASE_PATH)\(self.posterPath)"
    }
    
    init() {
      
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
        id = try values.decode(Int.self, forKey: .id)
        video = try values.decode(Bool.self, forKey: .video)
        voteAverage = try values.decode(Float.self, forKey: .voteAverage)
        title = try values.decode(String.self, forKey: .title)
        popularity = try values.decode(Float.self, forKey: .popularity)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        originalLanguage = try values.decode(String.self, forKey: .originalLanguage)
        originalTitle = try values.decode(String.self, forKey: .originalTitle)
        genreIds = try values.decode([Int].self, forKey: .genreIds)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        adult = try values.decode(Bool.self, forKey: .adult)
        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
    }
}
