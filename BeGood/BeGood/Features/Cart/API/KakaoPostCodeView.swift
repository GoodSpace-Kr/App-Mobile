//
//  KakaoPostCodeView.swift
//  BeGood
//
//  Created by minseok on 7/24/25.
//

import SwiftUI
import WebKit

struct KakaoPostCodeView: UIViewRepresentable {
    let request: URLRequest
    var webView: WKWebView?
    
    @Binding var isShowingKakaoWebSheet: Bool
    @Binding var address: String
    @Binding var zipcode: String
    
    init(
        request: URLRequest,
        isShowingKakaoWebSheet: Binding<Bool>,
        address: Binding<String>,
        zipcode: Binding<String>
    ) {
        self.webView = WKWebView()
        self.request = request
        self._isShowingKakaoWebSheet = isShowingKakaoWebSheet
        self._address = address
        self._zipcode = zipcode
        self.webView?.configuration.userContentController.add(
            KakaoWebController(
                isShowingkakaoWebSheet: _isShowingKakaoWebSheet,
                address: _address,
                zipcode: _zipcode
            ),
            name: "callBackHandler"
        )
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView!
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: KakaoPostCodeView
        
        init(parent: KakaoPostCodeView) {
            self.parent = parent
        }
    }
}

class KakaoWebController: NSObject, WKScriptMessageHandler {
    @Binding var isShowingKakaoWebSheet: Bool
    @Binding var address: String
    @Binding var zipcode: String
    
    init(
        isShowingkakaoWebSheet: Binding<Bool>,
        address: Binding<String>,
        zipcode: Binding<String>
    ) {
        self._isShowingKakaoWebSheet = isShowingkakaoWebSheet
        self._address = address
        self._zipcode = zipcode
    }


    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "callBackHandler",
               let data = message.body as? [String: Any] {

                print("✅ 메시지 수신: \(message.body)")

                if let roadAddress = data["roadAddress"] as? String {
                    address = roadAddress
                }

                if let zonecode = data["zonecode"] as? String {
                    zipcode = zonecode // ✅ 여기서 바인딩 연결
                }

                isShowingKakaoWebSheet.toggle()
            }
        }
}
