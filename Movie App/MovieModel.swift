//
//  MovieModel.swift
//  Movie App
//
//  Created by Bthloo on 24/09/2024.
//
//
//import Foundation
//
//struct Movie : Codable{
//    let title : String
//    let year : String
//    let poster : String
//    let runtime : String
//}
//
//typealias Movies = [Movie]



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movie = try? JSONDecoder().decode(Movie.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Movie
struct Movie: Codable {
    let movies: [MovieElement]
}

// MARK: - MovieElement
struct MovieElement: Codable {
    let title, year, runtime: String
    let poster: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case poster = "Poster"
    }
}

