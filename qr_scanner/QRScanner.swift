//
//  QRScanner.swift
//  qr_scanner
//
//  Created by Jan Přikryl on 24.05.2023.
//

import UIKit
import SwiftUI
import SwiftQRCodeScanner

struct QRScanner: UIViewControllerRepresentable {
    @Binding var result: Result<String, QRCodeError>?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> QRScanner.Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> QRCodeScannerController {
        var configuration = QRScannerConfiguration()
        configuration.title = "Načtěte QR kód"
        configuration.hint = "Umístěte QR kód do rámečku"
        configuration.uploadFromPhotosTitle = "Vybrat z fotek"
        configuration.invalidQRCodeAlertTitle = "Neplatný QR kód"
        configuration.cancelButtonTitle = "Zavřít"
        
        let picker = QRCodeScannerController(qrScannerConfiguration: configuration)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: QRCodeScannerController, context: Context) {
        
    }
}

extension QRScanner {
    class Coordinator: NSObject, QRScannerCodeDelegate {
        var parent: QRScanner
        @Environment(\.presentationMode) var presentationMode
        
        init(_ parent: QRScanner) {
            self.parent = parent
        }
        
        func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
            parent.result = .success(result)
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func qrScannerDidFail(_ controller: UIViewController, error: SwiftQRCodeScanner.QRCodeError) {
            parent.result = .failure(error)
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func qrScannerDidCancel(_ controller: UIViewController) {
            print("QR Controller did cancel")
        }
    }
}
