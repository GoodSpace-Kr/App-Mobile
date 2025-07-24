//
//  LostPasswordView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct LoginView: View {
    
    
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationStack {
            VStack{
                Image("goodspace_small")
                    .resizable()
                    .frame(width: 250, height: 70)
                    .padding(.bottom, 60)
                Text("로그인")
                    .font(.title)
                    .padding(.bottom)
                Text("이메일과 비밀번호를 입력해주세요.")
                TextField("이메일", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 0).stroke(Color.gray))
                
                // 비밀번호 입력
                SecureField("비밀번호", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 0).stroke(Color.gray))
                HStack {
                    NavigationLink(destination: LostPasswordView()) {
                        Text("비밀번호를 잊으셨나요?")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                // 로그인 버튼
                Button(action: {
                    print("로그인 시도")
                }) {
                    Text("로그인")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.black)
                }
                
                // 회원가입 버튼
                NavigationLink(destination: SignupView()) {
                    Text("회원가입")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                .padding(.bottom, 10)
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                    .padding(.bottom, 10)
                HStack {
                    Image("Kakao")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                    Image("Apple")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                    Image("Google")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                    Image("Naver")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                    Image("Facebook")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                
            }
            .padding(.horizontal, 40)
        }
    }
    
}



#Preview {
    LoginView()
}
