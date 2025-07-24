//
//  CreatorListView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct CreatorListView: View {
    @State private var creatorORinfluencer: String = ""
    @StateObject private var viewModel = PeopleViewModel()
    @State private var showSearch = false

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    headerSection
                    ScrollView {
                        VStack(alignment: .leading, spacing: 30) {
                            creatorSection
                            influencerSection
                        }
                        .padding(.top, 30)
                    }
                }
                .padding(.top, 50)
            }
            .sheet(isPresented: $showSearch) {
                SearchView(showSearch: $showSearch, viewModel: viewModel)
            }
        }
    }

    private var headerSection: some View {
        VStack {
            Image("goodspace_small")
                .resizable()
                .frame(width: 280, height: 70)
            Text("입주 현황")
                .font(.title)
            TextField("\(Image(systemName: "magnifyingglass")) 누가 입점해있을까요?", text: $creatorORinfluencer)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .font(.title3)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(lineWidth: 1)
                )
                .frame(width: 345)
                .disabled(true)
                .contentShape(Rectangle())
                .onTapGesture {
                    showSearch = true
                }
        }
    }

    private var creatorSection: some View {
        VStack(alignment: .leading) {
            Text("# 크리에이터")
                .font(.title3)
                .padding(.leading, 30)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.creators) { creator in
                        Image(creator.imageName)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.leading, 30)
            }
        }
    }

    private var influencerSection: some View {
        VStack(alignment: .leading) {
            Text("# 인플루언서")
                .font(.title3)
                .padding(.leading, 30)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(viewModel.influencers) { influencer in
                        NavigationLink(destination: CustomerLanding()) {
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
    }

}

#Preview {
    CreatorListView()
}
