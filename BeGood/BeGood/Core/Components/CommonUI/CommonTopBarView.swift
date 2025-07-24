//
//  CommonTopBarView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct CommonTopBarView<CenterContent: View>: View {
    var showBackButton: Bool = true
    var onBack: (() -> Void)? = nil
    var onCart: (() -> Void)? = nil
    let centerContent: () -> CenterContent

    init(
        showBackButton: Bool = true,
        onBack: (() -> Void)? = nil,
        onCart: (() -> Void)? = nil,
        @ViewBuilder centerContent: @escaping () -> CenterContent
    ) {
        self.showBackButton = showBackButton
        self.onBack = onBack
        self.onCart = onCart
        self.centerContent = centerContent
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if showBackButton {
                    Button(action: { onBack?() }) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                } else {
                    Spacer().frame(width: 24)
                }

                Spacer()

                centerContent()

                Spacer()

                Button(action: { onCart?() }) {
                    Image(systemName: "bag")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 20)
            .padding(.bottom, 12)
            .background(Color.white)
        }
    }
}
