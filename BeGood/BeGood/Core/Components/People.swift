//
//  People.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import Foundation

struct Creator: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct Influencer: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let imageName: String
}

