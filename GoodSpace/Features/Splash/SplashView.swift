//
//  SplashView.swift
//  GoodSpace
//
//  Created by minseok on 7/16/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Image("goodspace_transparent")
                .resizable()
                .frame(width: 300, height: 300)
        }
        
    }
}

