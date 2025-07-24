//
//  SplashView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
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

