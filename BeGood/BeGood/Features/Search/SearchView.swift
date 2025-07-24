//
//  SearchView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct SearchView: View {
    @Binding var showSearch: Bool
    @FocusState private var isFocused: Bool
    @State private var keyword = ""
    @State private var recentKeywords: [String] = []
    @ObservedObject var viewModel: PeopleViewModel
    
    @State private var filteredCreators: [Creator] = []
    @State private var filteredInfluencers: [Influencer] = []
    


    @State private var suggestedCreators: [Creator] = []
    @State private var searchMessage: String? = nil
    
    @State private var selectedCreator: Creator?
    @State private var selectedInfluencer: Influencer?
    @State private var isNavigatingToCreatorDetail = false
    @State private var isNavigatingToInfluencerDetail = false
    @State private var isNavigatingToSearchFail = false

    
    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration:0.3)) {
                            showSearch = false
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 8)
                    ZStack{
                        TextField("\(Image(systemName: "magnifyingglass")) 크리에이터를 검색해보세요!", text: $keyword)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .font(.title3)
                            .background(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(lineWidth: 1)
                            )
                            .frame(width:345)
                            .focused($isFocused)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isFocused = true
                                }
                            }
                            .onChange(of: keyword) { newValue in
                                let (creators, influencers) = viewModel.search(keyword: newValue)
                                filteredCreators = creators
                                filteredInfluencers = influencers
                            }
                            .onSubmit {
                                let lowerKeyword = keyword.lowercased()
                                
                                if !recentKeywords.contains(keyword) {
                                        recentKeywords.insert(keyword, at: 0)
                                    }

                                    if let matchedCreator = viewModel.creators.first(where: { $0.name.lowercased() == lowerKeyword }) {
                                        selectedCreator = matchedCreator
                                        return
                                    }

                                    if let matchedInfluencer = viewModel.influencers.first(where: { $0.name.lowercased() == lowerKeyword }) {
                                        selectedInfluencer = matchedInfluencer
                                        return
                                    }

                                // 일치하지 않으면 실패 뷰로
                                isNavigatingToSearchFail = true
                            }
                        
                        HStack{
                            Spacer()
                            if !keyword.isEmpty {
                                Button(action: {
                                    keyword = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 16)
                            }
                        }
                        .frame(width:345)
                        
                    }
                    
                }
                .padding()
                
                if !recentKeywords.isEmpty {
                    Text("최근 검색어")
                        .font(.subheadline).bold()
                        .padding(.top)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(recentKeywords, id: \.self) { word in
                                HStack(spacing: 4) {
                                    Text(word)
                                        .foregroundColor(.black)

                                    Button(action: {
                                        // 🔥 개별 검색어 삭제
                                        if let index = recentKeywords.firstIndex(of: word) {
                                            recentKeywords.remove(at: index)
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(20)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                Text("입점 크리에이터")
                    .font(.subheadline).bold()
                    .padding(.top)
                HStack {
                    ForEach(viewModel.creators, id: \.id) { creator in
                        Text(creator.name)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                
                Text("입점 인플루언서")
                    .font(.subheadline).bold()
                    .padding(.top)
                HStack {
                    ForEach(viewModel.influencers, id: \.id) { influencer in
                        Text(influencer.name)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
                
            }
            .background(Color.white.ignoresSafeArea())
            .navigationDestination(item: $selectedCreator) { creator in
                CustomerLanding()
            }
            .navigationDestination(item: $selectedInfluencer) { influencer in
                CustomerLanding()
            }
            .navigationDestination(isPresented: $isNavigatingToSearchFail) {
                SearchFailView()
            }
        }
        
    }
    struct WrapHStack: View {
        let items: [String]

        var body: some View {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 10)], spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
        }
    }

}

