//
//  AppRouter.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

enum AppRoute: Hashable {
    case creatorList
    case login
    case cart
}

struct AppRouter: View {
    @State private var showSplash = true

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
            } else {
                MainTabView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}
