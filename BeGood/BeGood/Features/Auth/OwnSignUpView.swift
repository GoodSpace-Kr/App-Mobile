//
//  OwnSignUpView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct OwnSignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPasswordMismatchAlert = false
    @State private var showPasswordRuleAlert = false
    @State private var isPasswordVisible: Bool = false
    // -----------------------------------------------
    @State private var isAgreeAll: Bool = false
    @State private var isAgree14: Bool = false
    @State private var isAgreeTerms: Bool = false
    @State private var isAgreePrivacy: Bool = false
    // -----------------------------------------------
    @FocusState private var isEmailFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image("goodspace_small")
                    .resizable()
                    .frame(width: 250, height: 70)
                    .padding(.vertical, 40)
                // 이메일 입력 + 인증 버튼
                HStack {
                    TextField("이메일 주소를 입력해주세요.", text: $email)
                        .focused($isEmailFocused)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.vertical, 12)
                        .overlay(Rectangle().frame(height: 1).padding(.top, 40), alignment: .bottom)
                        .foregroundColor(.black)
                    
                    Button(action: {
                        print("인증 이메일 발송")
                    }) {
                        Text("인증 이메일 발송")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .foregroundColor(.white)
                            .background(isEmailFocused ? Color.black : Color.gray)
                            .cornerRadius(20)
                    }
                    .disabled(!isEmailFocused)
                }
                
                // 비밀번호 입력
                HStack {
                    if isPasswordVisible {
                        TextField("비밀번호를 입력해주세요.", text: $password)
                    } else {
                        SecureField("비밀번호를 입력해주세요.", text: $password)
                    }
                    
                    // ❌ X 버튼 (조건부 표시)
                    if !password.isEmpty {
                        Button(action: {
                            password = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.black)
                        }
                    }
                    
                    // 👁️ 눈 아이콘
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(isPasswordVisible ? .black : .gray)
                    }
                    
                }
                .padding(.vertical, 12)
                .overlay(Rectangle().frame(height: 1).padding(.top, 40), alignment: .bottom)
                
                // 비밀번호 조건 설명
                HStack(spacing: 10) {
                    Label("영어, 숫자, 특수문자 포함 10자 이상", systemImage: "chevron.down")
                        .foregroundColor(isValidLengthAndComposition ? .black : .gray)
                    Label("연속 문자 불가", systemImage: "chevron.down")
                        .padding(.bottom)
                        .foregroundColor(isNotSequentialOrRepeated ? .black : .gray)
                    Label("이메일(아이디) 불가", systemImage: "chevron.down")
                        .padding(.bottom)
                        .foregroundColor(isNotEmailLike ? .black : .gray)
                }
                .font(.caption)
                .foregroundColor(.gray)
                
                // 비밀번호 확인
                SecureField("비밀번호를 확인해주세요.", text: $confirmPassword)
                    .padding(.vertical, 12)
                    .overlay(Rectangle().frame(height: 1).padding(.top, 40), alignment: .bottom)
                
                // ✅ 전체 동의
                CheckBoxRow(
                    title: "전체 동의",
                    isChecked: $isAgreeAll,
                    onTap: {
                        let newValue = !isAgreeAll
                        isAgreeAll = newValue
                        isAgree14 = newValue
                        isAgreeTerms = newValue
                        isAgreePrivacy = newValue
                    },
                    trailingView: { EmptyView() } // 명시적으로 넣어줌!
                ).padding(.top, 30)
                
                Divider()
                    .frame(height: 1)
                
                // ✅ 개별 체크박스
                CheckBoxRow(
                    title: "만 14세 이상입니다.",
                    isChecked: $isAgree14,
                    onTap: {
                        isAgree14.toggle()
                        updateAgreeAll()
                    },
                    trailingView: { EmptyView() }
                )
                
                CheckBoxRow(
                    title: "이용약관 동의",
                    isChecked: $isAgreeTerms,
                    onTap: {
                        isAgreeTerms.toggle()
                        updateAgreeAll()
                    },
                    trailingView: {
                        Button(action: {
                            print("이용약관 보기")
                        }) {
                            Text("보기")
                                .underline()
                                .foregroundColor(.gray)
                        }
                    }
                )
                
                
                CheckBoxRow(title: "개인정보수집·이용 동의", isChecked: $isAgreePrivacy) {
                    isAgreePrivacy.toggle()
                    updateAgreeAll()
                } trailingView: {
                    Button(action: {
                        print("개인정보 보기")
                    }) {
                        Text("보기")
                            .underline()
                            .foregroundColor(.gray)
                    }
                }
                
                // ✅ 가입 완료 버튼
                Button(action: {
                    if !isValidLengthAndComposition {
                        showPasswordRuleAlert = true
                    }
                    else if password != confirmPassword {
                        showPasswordMismatchAlert = true
                    } else {
                        print("가입 완료 - 비밀번호 일치")
                    }
                }) {
                    Text("가입 완료하기")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormComplete ? Color.black : Color.gray)
                        .cornerRadius(8)
                }
                .disabled(!isFormComplete)
                .alert("비밀번호를 확인해주세요.", isPresented: $showPasswordMismatchAlert){
                    Button("확인", role: .cancel) { }
                }
                .alert("비밀번호 조건을 확인해주세요.", isPresented: $showPasswordRuleAlert) {
                    Button("확인", role: .cancel) { }
                }
            }
            .padding()
        }
    }
    var isValidLengthAndComposition: Bool {
        !password.isEmpty &&
        password.count >= 10 &&
        password.range(of: "[A-Za-z]", options: .regularExpression) != nil &&
        password.range(of: "[0-9]", options: .regularExpression) != nil &&
        password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil
    }
    
    // MARK: - 조건 2: 반복/연속 문자 금지
    var isNotSequentialOrRepeated: Bool {
        !password.isEmpty &&
        !containsRepeatedCharacters(password) &&
        !containsSequentialCharacters(password)
    }
    
    // MARK: - 조건 3: 이메일 형태 방지
    var isNotEmailLike: Bool {
        !password.isEmpty &&
        !password.contains("@")
    }
    
    // MARK: - Helper 1: 같은 문자 3번 이상 반복 검사
    func containsRepeatedCharacters(_ text: String) -> Bool {
        let chars = Array(text)
        guard chars.count >= 3 else { return false }
        
        for i in 0..<chars.count - 2 {
            if chars[i] == chars[i + 1] && chars[i] == chars[i + 2] {
                return true
            }
        }
        return false
    }
    
    // MARK: - Helper 2: 연속 문자 검사 (abc, 123 등)
    func containsSequentialCharacters(_ text: String) -> Bool {
        let chars = Array(text.unicodeScalars.map { $0.value })
        guard chars.count >= 3 else { return false }
        
        for i in 0..<chars.count - 2 {
            if chars[i] + 1 == chars[i + 1] &&
                chars[i + 1] + 1 == chars[i + 2] {
                return true
            }
        }
        return false
    }
    
    // 전체 체크 여부 업데이트
    func updateAgreeAll() {
        isAgreeAll = isAgree14 && isAgreeTerms && isAgreePrivacy
    }
    
    // 체크박스 함수
    var isFormComplete: Bool {
        // 실제에선 email/password/confirmPassword 조건도 함께 포함!
        return !email.isEmpty &&
                   !password.isEmpty &&
                   !confirmPassword.isEmpty &&
                   isAgree14 &&
                   isAgreeTerms &&
                   isAgreePrivacy
    }
}

struct CheckBoxRow<TrailingView: View>: View {
    let title: String
    @Binding var isChecked: Bool
    var onTap: () -> Void
    var trailingView: (() -> TrailingView)?

    var body: some View {
        HStack {
            Button(action: onTap) {
                HStack(spacing: 10) {
                    Image(systemName: isChecked ? "checkmark.square" : "square")
                        .foregroundColor(.black)
                    Text(title)
                        .foregroundColor(.black)
                        .bold()
                }
            }
            Spacer()
            if let trailing = trailingView {
                trailing()
            }
        }
    }
}


#Preview {
    OwnSignUpView()
}
