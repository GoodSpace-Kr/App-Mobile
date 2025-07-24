//
//  ProductDetailView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct ProductDetailView: View {
    // -----------------TopBar-----------------------
    @Environment(\.dismiss) private var dismiss
    @State private var islogin = false
    @State private var navigateToCart = false
    @State private var navigateToLogin = false
    // -----------------------------------------------
    @State private var quantity = 1
    let pricePerItem = 35000
    
    var totalPrice: Int {
        return quantity * pricePerItem
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0){
                CommonTopBarView(
                    onBack: { dismiss() },
                    onCart: {
//                        if islogin {
//                            navigateToCart = true
//                        } else {
//                            navigateToLogin = true
//                        }
                        navigateToCart = true
                    }
                ) {
                    Image("goodspace_small")
                        .resizable()
                        .frame(width: 100, height: 28)
                }
                ScrollView{
                    ProductImageCarouselView()
                    Text("럭키 귀염둥이 LD 인형[12cm]")
                        .padding(.trailing, 110)
                        .padding(.vertical)
                    HStack{
                        Text("1개당")
                        Text("35,000원").font(.title3).bold()
                            .padding(.trailing, 90)
                        Text("배송비 3,000원")
                            .font(.system(size:13))
                            .foregroundColor(Color.gray)
                    }
                    Divider()
                        .frame(width: 330, height: 1)
                    Text("수량")
                        .font(.subheadline)
                        .padding(.trailing, 285)
                        .padding(.vertical)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            if quantity > 1 {
                                quantity -= 1
                            }
                        }) {
                            Text("-")
                                .font(.title2)
                                .frame(width: 32, height: 32)
                            
                        }
                        
                        Text("\(quantity)")
                            .font(.title3)
                            .frame(width: 24)
                        
                        Button(action: {
                            quantity += 1
                        }) {
                            Text("+")
                                .font(.title2)
                                .frame(width: 32, height: 32)
                            
                        }
                        
                        Text("\(totalPrice.formattedWithSeparator()) 원")
                            .font(.headline)
                            .bold()
                            .padding(.leading, 100)
                    }
                    
                }
                footerBar
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
    var footerBar: some View {
        VStack(spacing: 8) {
            // ✅ 수량 + 총 가격 라벨
            HStack {
                Text("수량 \(quantity)개")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("\((quantity * pricePerItem).formattedWithSeparator())원")
                    .font(.subheadline)
                    .bold()
            }
            .padding(.horizontal, 4) // 텍스트와 버튼 사이 여백

            // ✅ 버튼들
            HStack(spacing: 12) {
                Button(action: {
                    print("장바구니 담기")
                }) {
                    Text("장바구니 담기")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                }

                Button(action: {
                    print("바로 구매하기")
                }) {
                    Text("구매하기")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 10, y: -5)
        )
        .padding(.horizontal)
        .padding(.bottom, 10)
    }

        
}

extension Int {
    /// 35000 → "35,000"
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

struct ProductImageCarouselView: View {
    let images = ["luckyDoll", "lilly", "golden"] // asset 이름들

    var body: some View {
        TabView {
            ForEach(images, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 280, height: 280)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 300) // 세로 높이 고정
    }
}

#Preview {
    ProductDetailView()
}
