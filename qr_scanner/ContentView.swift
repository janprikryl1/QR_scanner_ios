//
//  ContentView.swift
//  qr_scanner
//
//  Created by Jan Přikryl on 24.05.2023.
//

import SwiftUI
import SwiftQRCodeScanner

struct ContentView: View {
    @State private var isPresented = false
        @State private var result: Result<String, QRCodeError>?
        
        var body: some View {
            VStack(spacing: 30) {
                if let unwrappedResult = result {
                    switch unwrappedResult {
                    case .success(let qrCodeString):
                        Text(qrCodeString)
                    case .failure(let qrCodeError):
                        Text(qrCodeError.errorDescription ?? "")
                            .foregroundColor(.red)
                    }
                }
                Button("Načtěte QR kód zboží") {
                    self.isPresented = true
                }
            }.sheet(isPresented: $isPresented) {
                QRScanner(result: self.$result)
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
