//
//  CartView.swift
//  BeGood
//
//  Created by minseok on 7/23/25.
//

import SwiftUI

struct CartView: View {
    // -----------------TopBar-----------------------
    @Environment(\.dismiss) private var dismiss
    @State private var islogin = false
    // -----------------------------------------------
    @State private var quantity = 1
    let pricePerItem = 3800
    
    var totalPrice: Int {
        return quantity * pricePerItem
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                CommonTopBarView(
                    onBack: { dismiss() },
                    onCart: { islogin = true }
                ) {
                    Text("장바구니")
                }
                ScrollView{
                    VStack{
                        Color.gray.opacity(0.2)
                            .frame(height: 40)
                        HStack{
                            Image("luckyDoll")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .border(Color.gray, width: 1)
                                .padding(.trailing,20)
                            VStack{
                                Text("럭키 키링")
                                    .bold()
                                    .padding(.bottom, 40)
                                Text("3,800원")
                            }
                            .padding(.trailing, 15)
                            
                            VStack {
                                Button(action: {
                                    // 삭제 기능은 아직 구현 안 함
                                    print("❌ 버튼 클릭됨")
                                }) {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .padding(8)
                                }
                                .offset(x: 60, y:-20)
                                HStack(spacing: 20) {
                                    Button(action: {
                                        if quantity > 1 {
                                            quantity -= 1
                                        }
                                    }) {
                                        Text("-")
                                            .font(.title2)
                                            .frame(width: 32, height: 32)
                                        
                                    }
                                    
                                    Text("\(quantity)")
                                        .font(.title3)
                                        .frame(width: 24)
                                    
                                    Button(action: {
                                        quantity += 1
                                    }) {
                                        Text("+")
                                            .font(.title2)
                                            .frame(width: 32, height: 32)
                                        
                                    }
                                    
                                }
                                .offset(x: 10, y: -10)
                                Text("\(totalPrice.formattedWithSeparator()) 원")
                                    .font(.headline)
                                    .bold()
                                    .offset(x: 40, y: 20)
                                
                            }
                            
                        }
                        .padding(.vertical, 25)
                        Color.gray.opacity(0.2)
                            .frame(height: 20)
                        
                        VStack{
                            Text("주문 요약")
                                .font(.title).bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 10)
                            HStack{
                                Text("키링")
                                Spacer()
                                Text("3,800원")
                            }
                            Divider()
                            HStack{
                                Text("주문 건수")
                                    .foregroundColor(Color.gray)
                                Spacer()
                                Text("1개")
                            }
                            HStack{
                                Text("총 상품 금액")
                                    .foregroundColor(Color.gray)
                                Spacer()
                                Text("3,800원")
                            }
                            HStack{
                                Text("배송비")
                                    .foregroundColor(Color.gray)
                                Spacer()
                                Text("3,000원")
                            }
                            Divider()
                            HStack{
                                Text("총 결제 금액")
                                    .font(.title2).bold()
                                Spacer()
                                Text("6,800원")
                                    .font(.title2).bold()
                            }
                            NavigationLink(destination: OrderView()) {
                                Text("구매하기")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .cornerRadius(0)
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .top)
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    CartView()
}
