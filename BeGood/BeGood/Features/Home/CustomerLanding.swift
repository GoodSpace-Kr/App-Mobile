//
//  CustomerLanding.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct CustomerLanding: View {
    @State private var selectedTab: Tab = .home
    @State private var isLogin = false
    @State private var navigateToCart = false
    @State private var navigateToLogin = false

    @Environment(\.dismiss) private var dismiss
    
    enum Tab {
        case home, search, my
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // ✅ TopBar
                CommonTopBarView(
                    onBack: { dismiss() },
                    onCart: {
                        if isLogin {
                            navigateToCart = true
                        } else {
                            navigateToLogin = true
                        }
                    }
                ) {
                    Image("goodspace_small")
                        .resizable()
                        .frame(width: 100, height: 28)
                }
                
                
                // ✅ 본문 (홈 화면 - 크리에이터 리스트)
                VStack{
                    ZStack(alignment: .bottomLeading) {
                        Image("luckyBack") // 배경 이미지
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                            .grayscale(0.5)
                        
                        HStack(spacing: 8) {
                            Image("lucky") // 프로필 이미지
                                .resizable()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            
                            Text("럭키")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 20)
                        .padding(.bottom, 16)
                    }
                    ScrollView{
                        
                        NavigationLink(destination: ProductDetailView()) {
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("귀여운 인형")
                                        .font(.title).bold()
                                    Text("크리에이터를 내 품에")
                                        .font(.title2)
                                    Text("작아진 럭키를 어디서든 볼 수 있습니다.")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Image("luckyDoll")
                                    .resizable()
                                    .frame(width: 130, height: 130)
                            }
                            .frame(height:130)
                            .padding()
                            .background(Color(red: 1.0, green: 0.7, blue: 0.7))
                        }.buttonStyle(PlainButtonStyle()) // 연핑크
                        
                        // 🧩 상품 2
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("귀여운 키링")
                                    .font(.title).bold()
                                Text("크리에이터를 내 품에")
                                    .font(.title2)
                                Text("작아진 럭키를 어디서든 볼 수 있습니다.")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image("luckyKeyring")
                                .resizable()
                                .frame(width: 130, height: 130)
                        }
                        .frame(height:130)
                        .padding()
                        .background(Color(red: 1.0, green: 0.8, blue: 0.8))
                    }
                }
                
                
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $navigateToCart) {
                CartView()
            }
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
            }
        }
    }
}
#Preview {
    CustomerLanding()
}
