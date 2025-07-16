//
//  InfluencerDetailView.swift
//  GoodSpace
//
//  Created by minseok on 7/16/25.
//

import SwiftUI

struct InfluencerDetailView: View {
    let influencer: Influencer
    
    var body: some View {
        VStack{
            Text("인플루언서 이름: \(influencer.name)")
        }
    }
}

#Preview {
    InfluencerDetailView(influencer: Influencer(name: "럭키", imageName: "lucky"))
}
