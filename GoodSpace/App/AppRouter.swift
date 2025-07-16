//
//  AppRouter.swift
//  GoodSpace
//
//  Created by minseok on 7/16/25.
//  AppRoute, 화면 전환을 구현합니다.
//  새 화면이 필요하면 enum에 뷰 이름을 넣고 body 내부의 .navigationDestination switch문에
//  case를 추가하면 됩니다.

import SwiftUI

enum AppRoute: Hashable {
    case creatorList
}

struct AppRouter: View {
    @State private var path: [AppRoute] = []
    @State private var showSplash = true
    var body: some View {
        ZStack{
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else {
                NavigationStack {
                    CreatorListView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}

#Preview {
    AppRouter()
}
