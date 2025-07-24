//
//  EditSocialView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct EditSocialView: View {
    // -----------------TopBar-----------------------
    @Environment(\.dismiss) private var dismiss
    @State private var islogin = false
    @State private var navigateToCart = false
    @State private var navigateToLogin = false
    // -----------------------------------------------
    // 우편번호 찾기 api 연동을 위한 변수들
    @State var isShowingKakaoWebSheet: Bool = false
    @State var address: String = ""
    @State var zipcode: String = ""
    @State var detailAddress: String = ""
    let webURL: URL? = URL(string: "https://staralstjr.github.io/DaumApi/")
    // -----------------------------------------------
    @State private var selectedGender: String = ""

    var body: some View {
        NavigationStack{
            VStack{
                CommonTopBarView(
                    onBack: { dismiss() },
                    onCart: { islogin = true }
                ) {
                    Text("계정정보 변경")
                }
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Section Header
                        
                        VStack(alignment: .leading, spacing: 16) {
                            // Section Title
                            Text("연결된 SNS 계정")
                                .font(.headline)
                                .bold()

                            // 카카오 이미지 + 이메일(아이디) + 이메일 변경 버튼
                            HStack {
                                Image("Kakao")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    HStack {
                                        Text("이메일(아이디)")
                                            .font(.subheadline)
                                            .bold()
                                        Text("*")
                                            .foregroundColor(.orange)
                                            .font(.subheadline)
                                    }
                                    
                                    Text("minseok123@daum.net")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                
                            }
                        }
                        VStack(alignment: .leading, spacing: 4) {
                            Text("개인정보 입력")
                                .font(.headline)
                                .bold()
                        }

                        // 이름
                        VStack(alignment: .leading, spacing: 4) {
                            Text("이름")
                                .font(.subheadline)
                            TextField("", text: .constant(""))
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)
                        }

                        // 연락처
                        VStack(alignment: .leading, spacing: 4) {
                            Text("연락처")
                                .font(.subheadline)
                            TextField("하이픈(-) 없이 숫자만 입력해 주세요", text: .constant(""))
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)
                        }

                        // 우편번호 + 주소 검색 버튼
                        VStack(alignment: .leading, spacing: 4) {
                            Text("배송지")
                                .font(.subheadline)
                            HStack(spacing: 8) {
                                TextField("우편번호", text: $zipcode)
                                    .padding(8)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(4)

                                Button(action: {
                                    isShowingKakaoWebSheet = true
                                }) {
                                    Text("주소 검색")
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(Color.black)
                                        .cornerRadius(6)
                                }
                                .sheet(isPresented: $isShowingKakaoWebSheet) {
                                    if let url = webURL {
                                        KakaoPostCodeView(
                                            request: URLRequest(url: url),
                                            isShowingKakaoWebSheet: $isShowingKakaoWebSheet,
                                            address: $address,
                                            zipcode: $zipcode
                                        )
                                    }
                                }
                            }
                        }
                        

                        // 주소
                        TextField("주소", text: $address)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(4)

                        // 상세 주소
                        TextField("상세 주소", text: $detailAddress)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(4)

                        // 생년월일
                        VStack(alignment: .leading, spacing: 4) {
                            Text("생년월일")
                                .font(.subheadline)
                            TextField("생년월일을 입력해 주세요", text: .constant(""))
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)
                        }

                        // 성별 선택
                        VStack(alignment: .leading, spacing: 8) {
                            Text("성별")
                                .font(.subheadline)
                                .bold()

                            HStack {
                                RadioButton(text: "여자", isSelected: $selectedGender, value: "여자")
                                RadioButton(text: "남자", isSelected: $selectedGender, value: "남자")
                                RadioButton(text: "상관없음", isSelected: $selectedGender, value: "상관없음")
                            }
                        }

                        // 저장 버튼
                        NavigationLink(destination: ChangePasswordView()) {
                            Text("비밀번호 변경하기")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(8)
                        }
                        .padding(.bottom, 30)
                    }
                    .padding()
                }

            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarHidden(true)
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
    EditSocialView()
}
