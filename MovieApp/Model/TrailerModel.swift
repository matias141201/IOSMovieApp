//
//  TrailerModel.swift
//  MovieApp
//
//  Created by Matias Rodriguez on 14/04/2024.
//

import Foundation

struct TrailerResponse: Codable {
    let id: Int
    let results: [Trailer]
}

struct Trailer: Codable {
    let key: String
    let name: String
    let type: String
    let published_at: String
}
