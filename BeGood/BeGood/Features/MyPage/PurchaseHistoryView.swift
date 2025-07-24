//
//  PurchaseHistoryView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct PurchaseHistoryView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // MARK: - 주문 상태 요약
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 16) {
                    OrderStatusBox(count: 0, title: "결제 확인", subtitle: "주문하신 결제가 완료된 후 진행됩니다.")
                    OrderStatusBox(count: 0, title: "제작 준비중", subtitle: "주문하신 커스텀 상품 제작을 확인하고 준비하고 있습니다.")
                    OrderStatusBox(count: 0, title: "제작중", subtitle: "주문하신 커스텀 상품을 제작하고 있습니다.")
                    OrderStatusBox(count: 0, title: "배송 준비중", subtitle: "상품 배송을 준비하고 있습니다.")
                    OrderStatusBox(count: 0, title: "배송중", subtitle: "물품이 발송되어 고객님께 배송중입니다.")
                    OrderStatusBox(count: 0, title: "배송 완료", subtitle: "배송이 완료된 후 7일 이내 교환 / 반품신청이 가능합니다.")
                }
                .padding(.horizontal)

                Divider().padding(.horizontal)

                // MARK: - 주문 내역 헤더
                HStack {
                    Text("주문일자 / 주문번호")
                    Spacer()
                    Text("구매 상품정보")
                    Spacer()
                    Text("금액")
                    Spacer()
                    Text("진행상태")
                }
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)

                // MARK: - 최근 주문 없음 메시지
                VStack(spacing: 12) {
                    Text("최근 1개월 내 구매내역이 없습니다.")
                        .foregroundColor(.gray)
                        .font(.callout)
                        .padding(.top, 60)

                    Image(systemName: "cart")
                        .font(.system(size: 36))
                        .foregroundColor(.gray.opacity(0.5))
                }
                .frame(maxWidth: .infinity)

                Spacer()

                // MARK: - 페이지 네비게이션 (모양만 구현)
                HStack(spacing: 16) {
                    Image(systemName: "chevron.backward.2")
                    Text("<")
                    Text("1")
                        .fontWeight(.bold)
                    Text(">")
                    Image(systemName: "chevron.forward.2")
                }
                .foregroundColor(.gray)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("구매 내역")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 주문 상태 박스 View
struct OrderStatusBox: View {
    let count: Int
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(count)")
                .font(.title3)
                .fontWeight(.bold)
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    PurchaseHistoryView()
}
