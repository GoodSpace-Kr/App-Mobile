//
//  CreatorDetailView.swift
//  GoodSpace
//
//  Created by minseok on 7/16/25.
//

import SwiftUI

struct CreatorDetailView: View {
    let creator: Creator
    
    var body: some View {
        VStack{
            Text("크리에이터 이름: \(creator.name)")
        }
    }
}

#Preview {
    CreatorDetailView(creator: Creator(name: "침착맨", imageName: "chimchack"))
}

