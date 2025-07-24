import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showMismatchAlert = false
    @State private var showRuleAlert = false
    
    var body: some View {
        VStack(spacing: 24) {
            // Top Bar
            ZStack {
                Text("비밀번호 등록")
                    .font(.title3.bold())
                
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView {
                VStack(spacing: 28) {
                    // 현재 비밀번호
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("현재 비밀번호")
                                .bold()
                            Text("•")
                                .foregroundColor(.orange)
                        }
                        passwordField("현재 비밀번호를 입력해 주세요", text: $currentPassword)
                    }
                    
                    // 새 비밀번호
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("새 비밀번호")
                                .bold()
                            Text("•")
                                .foregroundColor(.orange)
                        }
                        passwordField("새 비밀번호를 입력해 주세요", text: $newPassword)
                        
                        // 조건 라벨들
                        VStack(alignment: .leading, spacing: 4) {
                            Label("영문, 숫자, 특수문자 포함 10자 이상", systemImage: "chevron.down")
                            Label("연속문자 불가", systemImage: "chevron.down")
                            Label("이메일(아이디) 불가", systemImage: "chevron.down")
                        }
                        .font(.caption)
                        .foregroundColor(.gray)
                    }
                    
                    // 비밀번호 확인
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            Text("새 비밀번호 확인")
                                .bold()
                            Text("•")
                                .foregroundColor(.orange)
                        }
                        passwordField("새 비밀번호를 다시 입력해 주세요", text: $confirmPassword)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
            
            Spacer()
            
            HStack(spacing: 12) {
                Button(action: {
                    dismiss()
                }) {
                    Text("취소")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color.black, lineWidth: 1))
                }
                
                Button(action: {
                    if !isValidPassword(newPassword) {
                        showRuleAlert = true
                    } else if newPassword != confirmPassword {
                        showMismatchAlert = true
                    } else {
                        print("✅ 비밀번호 등록")
                    }
                }) {
                    Text("등록")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isValidPassword(newPassword) && !confirmPassword.isEmpty ? Color.black : Color.gray)
                        .cornerRadius(30)
                }
                .disabled(!isValidPassword(newPassword) || confirmPassword.isEmpty)
            }
            .padding(.horizontal)
            .padding(.bottom)
            .alert("비밀번호가 일치하지 않습니다.", isPresented: $showMismatchAlert) {
                Button("확인", role: .cancel) { }
            }
            .alert("비밀번호 조건을 확인해주세요.", isPresented: $showRuleAlert) {
                Button("확인", role: .cancel) { }
            }
        }
    }
    
    func passwordField(_ placeholder: String, text: Binding<String>) -> some View {
        HStack {
            if isPasswordVisible {
                TextField(placeholder, text: text)
            } else {
                SecureField(placeholder, text: text)
            }
            
            if !text.wrappedValue.isEmpty {
                Button(action: {
                    text.wrappedValue = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.black)
                }
            }
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 12)
        .overlay(Rectangle().frame(height: 1).padding(.top, 40), alignment: .bottom)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 10 &&
        password.range(of: "[A-Za-z]", options: .regularExpression) != nil &&
        password.range(of: "[0-9]", options: .regularExpression) != nil &&
        password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil &&
        !password.contains("@") &&
        !containsSequential(password) &&
        !containsRepeated(password)
    }

    func containsSequential(_ text: String) -> Bool {
        let chars = Array(text.unicodeScalars.map { $0.value })
        for i in 0..<chars.count - 2 {
            if chars[i] + 1 == chars[i + 1] && chars[i + 1] + 1 == chars[i + 2] {
                return true
            }
        }
        return false
    }

    func containsRepeated(_ text: String) -> Bool {
        let chars = Array(text)
        for i in 0..<chars.count - 2 {
            if chars[i] == chars[i + 1] && chars[i] == chars[i + 2] {
                return true
            }
        }
        return false
    }
}

#Preview {
    ChangePasswordView()
}
