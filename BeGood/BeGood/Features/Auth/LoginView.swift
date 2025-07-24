//
//  LoginView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct LostPasswordView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showVerificationField = false
    @State private var verificationCode: String = ""
    
    var body: some View {
        VStack{
            Image("goodspace_small")
                .resizable()
                .frame(width: 250, height: 70)
                .padding(.bottom, 40)
            Text("비밀번호 찾기")
                .font(.title)
                .padding(.bottom, 50)
            HStack(spacing: 10) {
                TextField("이메일", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 0).stroke(Color.gray, lineWidth: 1))
                    .frame(maxWidth: .infinity) // 남는 공간 최대 사용

                Button(action: {
                    print("이메일 인증 누르면 인증번호 생기기")
                    showVerificationField = true
                }) {
                    Text("이메일 인증")
                        .foregroundColor(.black)
                        .padding(.horizontal)
                        .padding(.vertical, 16.5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                .fixedSize() // 버튼을 텍스트에 맞게 최소 크기로 고정
            }
            if showVerificationField {
                HStack(spacing: 10) {
                    TextField("이메일 인증 번호", text: $email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 0).stroke(Color.gray, lineWidth: 1))
                        .frame(maxWidth: .infinity) // 남는 공간 최대 사용

                    Button(action: {
                        print("이메일 확인")
                    }) {
                        Text("인증 확인")
                            .foregroundColor(.black)
                            .padding(.horizontal, 23)
                            .padding(.vertical, 16.5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    .fixedSize() // 버튼을 텍스트에 맞게 최소 크기로 고정
                }
            }
            
            SecureField("비밀번호", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 0).stroke(Color.gray))
            SecureField("비밀번호 확인", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 0).stroke(Color.gray))
            Button(action: {
                print("로그인 시도")
            }) {
                Text("로그인")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
            }
            
        }.padding(.horizontal, 40)
        
    }
}

#Preview {
    LostPasswordView()
}
