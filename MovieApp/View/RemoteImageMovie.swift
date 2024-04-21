//
//  RemoteImageMovie.swift
//  MovieApp
//
//  Created by Matias Rodriguez on 20/04/2024.
//

import SwiftUI
import Kingfisher

struct RemoteImageMovie: View {
    var url: String
    
    var body: some View {
        KFImage(URL(string: "\(Constants.urlImages)\(url)"))
            .resizable()
            .placeholder { progress in
                ProgressView()
            }
    }
}
