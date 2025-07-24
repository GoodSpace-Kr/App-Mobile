import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var islogin = false
    @State private var navigateToCart = false
    @State private var navigateToLogin = false

    @State private var address: String = ""
    @State private var zipcode: String = ""
    @State private var detailAddress: String = ""
    @State private var selectedGender: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                CommonTopBarView(
                    onBack: { dismiss() },
                    onCart: { islogin = true }
                ) {
                    Text("계정정보 변경")
                }

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        SectionHeader(title: "아이디･비밀번호 변경")

                        LabeledTextField(label: "아이디")
                        
                        NavigationLink(destination: ChangePasswordView()) {
                            Text("비밀번호 변경하기")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.black)
                                .cornerRadius(8)
                        }

                        SectionHeader(title: "개인정보 입력")

                        LabeledTextField(label: "이름")
                        LabeledTextField(label: "연락처")

                        HStack(spacing: 8) {
                            TextField("우편번호", text: $zipcode)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)

                            Button(action: {
                                print("주소 검색")
                            }) {
                                Text("주소 검색")
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color.black)
                                    .cornerRadius(6)
                            }
                        }

                        TextField("주소", text: $address)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(4)

                        TextField("상세 주소", text: $detailAddress)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(4)

                        LabeledTextField(label: "생년월일")

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

                        Button(action: {
                            print("저장하기")
                        }) {
                            Text("저장하기")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray)
                                .cornerRadius(8)
                        }
                        .padding(.bottom, 30)
                    }
                    .padding()
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

struct RadioButton: View {
    let text: String
    @Binding var isSelected: String
    let value: String

    var body: some View {
        Button(action: {
            isSelected = value
        }) {
            HStack(spacing: 6) {
                Image(systemName: isSelected == value ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.black)
                Text(text)
                    .foregroundColor(.black)
                    .font(.subheadline)
            }
        }
    }
}

#Preview{
    EditProfileView()
}
