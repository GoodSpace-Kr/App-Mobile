//
//  MainTabView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

// ✅ NavigationModel은 MainTabView 안쪽 또는 바깥에 선언 가능

class NavigationModel: ObservableObject {
    @Published var homePath = NavigationPath()
    @Published var myPagePath = NavigationPath()
}

struct MainTabView: View {
    @StateObject private var navModel = NavigationModel()
    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, search, my
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // 홈 탭
            NavigationStack(path: $navModel.homePath) {
                CreatorListView()
                    .navigationDestination(for: String.self) { value in
                        if value == "SomeDetail" {
                            Text("홈 상세 페이지") // 예시
                        }
                    }
            }
            .tabItem {
                Image(systemName: "house")
                Text("홈")
            }
            .tag(Tab.home)
            .onAppear {
                if selectedTab == .home {
                    navModel.homePath = NavigationPath()
                }
            }

            // 검색 탭
            SearchViewWrapper()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
                .tag(Tab.search)

            // 마이 탭
            NavigationStack(path: $navModel.myPagePath) {
                MyPageView()
                    .navigationDestination(for: String.self) { value in
                        if value == "ChangePassword" {
                            ChangePasswordView()
                        }
                    }
            }
            .tabItem {
                Image(systemName: "person")
                Text("마이")
            }
            .tag(Tab.my)
            .onAppear {
                if selectedTab == .my {
                    navModel.homePath = NavigationPath()
                }
            }
        }
        .environmentObject(navModel)
    }
}

struct SearchViewWrapper: View {
    @State private var dummy = false
    @StateObject private var viewModel = PeopleViewModel()

    var body: some View {
        SearchView(showSearch: $dummy, viewModel: viewModel)
    }
}


