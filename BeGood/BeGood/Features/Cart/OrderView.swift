//
//  OrderView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI
import SafariServices

struct OrderView: View {
    // -----------------TopBar-----------------------
    @Environment(\.dismiss) private var dismiss
    @State private var islogin = false
    // -----------------------------------------------
    @State private var selectedMemo = 0
    @State private var isNewAddress = false // ✅ 체크박스 상태
    // -----------------------------------------------
    // 우편번호 찾기 api 연동을 위한 변수들
    @State var isShowingKakaoWebSheet: Bool = false
    @State var address: String = ""
    @State var zipcode: String = ""
    @State var detailAddress: String = ""
    let webURL: URL? = URL(string: "https://staralstjr.github.io/DaumApi/")
    // -----------------------------------------------
    // 결제하기에 필요한 변수들(nicepay url 연결)
    @State private var agreePurchase = false
    @State private var agreeTerms = false
    @State private var agreePrivacy = false
    @State private var showWebView = false


    var body: some View {
        VStack {
            CommonTopBarView(
                onBack: { dismiss() },
                onCart: { islogin = true }
            ) {
                Text("주문하기")
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // MARK: - 주문자 정보 입력
                    Group {
                        SectionHeader(title: "주문자 정보 입력")
                        
                        LabeledTextField(label: "이름")
                        LabeledTextField(label: "연락처")
                        LabeledTextField(label: "이메일")
                        
                        Text("입력하신 이메일로 결제 관련 내용이 전송됩니다.")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    // MARK: - 배송지 정보
                    // 배송지 정보 Section
                    Group {
                        SectionHeader(title: "배송지 정보")

                        LabeledTextField(label: "수령인")
                        LabeledTextField(label: "연락처1")
                        LabeledTextField(label: "연락처2")

                        HStack {
                            Text("배송지")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                            CheckboxToggle(isChecked: $isNewAddress, label: "새 배송지 입력")
                        }

                        HStack(spacing: 8) {
                            TextField("우편번호", text: $zipcode)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(4)

                            Button(action: {
                                isShowingKakaoWebSheet = true
                            }) {
                                Text("찾아보기")
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
                            Spacer()
                        }

                        TextField("주소", text: $address)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(4)

                        TextField("상세 주소", text: $detailAddress)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(4)
                            .disabled(true)

                        Text("배송 메모")
                            .font(.subheadline)
                            .bold()

                        Picker(selection: $selectedMemo, label: Text("배송 메모를 선택해주세요")) {
                            Text("직접 수령").tag(0)
                            Text("부재 시 문 앞").tag(1)
                            Text("경비실에 맡겨주세요").tag(2)
                        }
                        .pickerStyle(.menu)
                        .padding(4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)
                    }

                    // MARK: - 총 결제 정보
                    Group {
                        SectionHeader(title: "총 결제 정보")

                        PaymentInfoRow(title: "주문 개수", value: "2개")
                        CustomDivider(color: .black, height: 1.2)

                        PaymentInfoRow(title: "총 상품 금액", value: "25,000원")
                        CustomDivider(color: .black, height: 1.2)

                        PaymentInfoRow(title: "배송비", value: "2,500원")
                        CustomDivider(color: .black, height: 1.2)

                        PaymentInfoRow(title: "총 결제 금액", value: "27,500원")
                        CustomDivider(color: .black, height: 1.2)
                    }
                    
                    // MARK: - 구매 전 확인 및 동의하기
                    Group {
                        SectionHeader(title: "구매 전 확인 및 동의하기")

                        CheckboxToggle(isChecked: $agreePurchase, label: "주문 상품 구매 동의(필수)")

                        Text("상품 주문시 완성된 상품과 일부 다를 수 있습니다. 구매 후 취소 및 환불은 입금 상태 확인 전 가능하며, 배송 완료 후 단순 변심에 의한 교환/반품은 불가합니다. 결제 전 주문내용을 반드시 확인해 주시기 바랍니다.  주문할 상품, 배송 정보를 확인하였으며, 구매에 동의하시겠습니까?")
                            .font(.caption)
                            .foregroundColor(.gray)
                        CustomDivider(color: .black, height: 1.2)
                        HStack(spacing: 4){
                            CheckboxToggle(isChecked: $agreeTerms, label: "이용약관 동의(필수)")
                            Spacer()
                            Button(action: {
                                // 추후 상세 페이지로 이동
                                print("이용약관 동의 보기 누름")
                            }) {
                                Text("보기")
                                    .font(.caption)
                                    .underline()
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        CustomDivider(color: .black, height: 1.2)
                        HStack(spacing: 4) {
                            CheckboxToggle(isChecked: $agreePrivacy, label: "개인 정보 수집 및 이용 동의(필수)")
                            Spacer()
                            Button(action: {
                                // 추후 상세 페이지로 이동
                                print("개인 정보 이용 보기 버튼 눌림")
                            }) {
                                Text("보기")
                                    .font(.caption)
                                    .underline()
                                    .foregroundColor(.blue)
                            }
                        }

                        CustomDivider()
                    }

                    // MARK: - 결제하기 버튼
                    Button(action: {
                        // 여기서 NICEPAY URL 받아서 WebView로 이동
                        showWebView = true
                    }) {
                        Text("결제하기")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 30)
                }
                .padding()
            }
        }
        .sheet(isPresented: $showWebView) {
            SafariView(url: URL(string: "https://demo.nicepay.co.kr/web/demo/demoPay.jsp")!)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}


struct CustomDivider: View { // 굵은 디바이더!!
    var color: Color = .black
    var height: CGFloat = 1.2

    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
    }
}

struct SectionHeader: View {
    let title: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .bold()
            CustomDivider(color: .black, height: 1.2)
        }
    }
}

struct LabeledTextField: View {
    let label: String
    @State private var text: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.subheadline)
            TextField("", text: $text)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(4)
        }
    }
}

// ✅ iOS에서도 사용할 수 있는 체크박스 모양의 Toggle 대체
struct CheckboxToggle: View {
    @Binding var isChecked: Bool
    let label: String

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            HStack(spacing: 6) {
                Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                    .foregroundColor(isChecked ? .blue : .gray)
                Text(label)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
        .buttonStyle(.plain)
    }
}

struct PaymentInfoRow: View {
    let title: String
    let value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.footnote)
            Spacer()
            Text(value)
                .font(.subheadline)
                .bold()
        }
    }
}


struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}





#Preview {
    OrderView()
}
