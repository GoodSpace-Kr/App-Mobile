//
//  CreatorListView.swift
//  GoodSpace
//
//  Created by minseok on 7/16/25.
// 2. 입주 현황 뷰
// 3. 입주된 크리에이터 랜딩 페이지

import SwiftUI

struct CreatorListView: View {
    @State var creatorORinfluencer: String = ""
    @StateObject private var viewModel = PeopleViewModel()
    @State private var showSearch = false
    
    var body: some View {
        ZStack{
            if !showSearch{
                VStack{
                    VStack{
                        Image("goodspace_small")
                            .resizable()
                            .frame(width: 280, height: 70)
                        Text("입주 현황")
                            .font(.title)
                        HStack {
                            TextField("\(Image(systemName: "magnifyingglass")) 누가 입점해있을까요?", text: $creatorORinfluencer)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .font(.title3)
                                .background(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(lineWidth: 1)
                                )
                                .frame(width:345)
                                .disabled(true)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            showSearch = true
                                        }
                                    }
                                }
                        }
                        .frame(maxWidth: .infinity)
                        .alignmentGuide(.leading) {_ in 0 }
                    }
                    ScrollView {
                        VStack{
                            Text("# 크리에이터")
                                .font(.title3)
                                .padding(.trailing, 230)
                                .padding(.top, 20)
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 16){
                                    ForEach(viewModel.creators) { creator in
                                        Image(creator.imageName)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                            }
                            .padding(.leading, 30)
                        }
                        VStack{
                            Text("# 인플루언서")
                                .font(.title3)
                                .padding(.trailing, 230)
                                .padding(.top, 20)
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 16){
                                    ForEach(viewModel.influencers) { influencer in
                                        Image(influencer.imageName)
                                            .resizable()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                            }
                            .padding(.leading, 30)
                        }
                    }
                }.padding(.top, 50)
                SearchView(showSearch: $showSearch, viewModel: viewModel)
                    .offset(y: showSearch ? 0 : UIScreen.main.bounds.height)
                    .animation(.easeInOut(duration: 0.5), value: showSearch)
                    .zIndex(1)
            }
        }
        if showSearch {
            SearchView(showSearch: $showSearch, viewModel: viewModel)
                .transition(.move(edge: .top))
        }
    }
    
}

#Preview {
    CreatorListView()
}
