//
//  MyPageView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

// MyPageView.swift
import SwiftUI

struct MyPageView: View {
    // -----------------TopBar-----------------------
    @Environment(\.dismiss) private var dismiss
    @State private var islogin = false
    @State private var navigateToCart = false
    @State private var navigateToLogin = false
    // -----------------------------------------------
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
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
                ScrollView {
                    VStack(spacing: 0) {
                        // MARK: - 프로필 영역
                        HStack(spacing: 16) {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                            
                            HStack {
                                Text("권민석님")
                                    .font(.title3)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                NavigationLink(destination: EditProfileView()) {
                                    
                                    Text("프로필 설정")
                                        .font(.caption)
                                        .foregroundColor(Color(UIColor.systemGray3))
                                    Image(systemName: "chevron.right")
                                }
                            }
                            Spacer()
                        }
                        .padding(.vertical, 30)
                        .padding(.horizontal)
                        .background(Color.black)

                        // MARK: - 메뉴 리스트
                        VStack(spacing: 1) {
                            MyPageRow(icon: "archivebox", label: "구매 내역", destination: PurchaseHistoryView())
                            MyPageRow(icon: "cart", label: "장바구니", destination: CartView())
                            Divider()

                            MyPageRow(icon: "person.text.rectangle", label: "개인정보 수집 및 이용", destination: Text("개인정보 수집 및 이용"))
                            MyPageRow(icon: "gear", label: "버전 정보", destination: Text("버전 정보"), rightText: "1.0.0")
                            MyPageRow(icon: "lightbulb", label: "고객센터", destination: Text("고객센터"))
                            Divider()

                            MyPageRow(icon: "person.crop.circle.badge.checkmark", label: "계정정보 변경", destination: EditProfileView())
                            MyPageRow(icon: "rectangle.portrait.and.arrow.right", label: "로그아웃", destination: Text("로그아웃"))
                            MyPageRow(icon: "trash", label: "탈퇴하기", destination: Text("탈퇴하기"))
                        }
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all, edges: .top)
            .navigationDestination(isPresented: $navigateToCart) {
                CartView()
            }
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
            }
        }
    }
}

struct MyPageRow<Destination: View>: View {
    let icon: String
    let label: String
    let destination: Destination
    var rightText: String? = nil

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .frame(width: 24)
                    .foregroundColor(.black)

                Text(label)
                    .foregroundColor(.black)

                Spacer()

                if let text = rightText {
                    Text(text)
                        .foregroundColor(.gray)
                        .font(.caption)
                }

                // ✅ 우측 화살표 아이콘
                Image(systemName: "chevron.right")
                    .font(.system(size: 14)) // ← 원하는 크기로 조절
                    .foregroundColor(.gray)

            }
            .padding(.vertical, 12)
            .padding(.horizontal)
        }
    }
}

#Preview {
    MyPageView()
}
