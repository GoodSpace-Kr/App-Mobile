//
//  SignUpView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct SignupView: View {
    var body: some View {
        NavigationStack {
            VStack{
                Image("goodspace_small")
                    .resizable()
                    .frame(width: 250, height: 70)
                    .padding(.bottom, 60)
                Text("회원가입")
                    .font(.title)
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
                }.padding(.horizontal, 10) // socialLogin
                
                Text("또는")
                    .foregroundColor(Color.gray)
                    .padding(.vertical, 10)
                NavigationLink(destination: OwnSignUpView()){
                    Text("이메일로 가입하기")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                
                HStack {
                    Text("이미 계정이 있으신가요?")
                        .foregroundColor(Color.gray)
                        .padding(.trailing, 5)
                    NavigationLink(destination:LoginView()){
                        Text("로그인하기")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal, 40)
            
        }
    }
}

#Preview {
    SignupView()
}
