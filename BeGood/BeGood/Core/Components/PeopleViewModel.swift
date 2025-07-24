//
//  PeopleViewModel.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import Foundation

class PeopleViewModel: ObservableObject {
    @Published var creators: [Creator] = []
    @Published var influencers: [Influencer] = []
    
    init() {
        loadCreators()
        loadInfluencers()
    }
    
    func loadCreators() {
        creators = [
            Creator(name: "침착맨", imageName: "chimchack"),
            Creator(name: "돌비 공포라디오", imageName: "dolbi")
        ]
    }
    func loadInfluencers() {
        influencers = [
            Influencer(name: "럭키", imageName: "lucky"),
        ]
    }
    func search(keyword: String) -> ([Creator], [Influencer]) {
        let filteredCreators = creators.filter { $0.name.contains(keyword)}
        let filteredInfluencers = influencers.filter { $0.name.contains(keyword) }
        return (filteredCreators, filteredInfluencers)
    }
}
