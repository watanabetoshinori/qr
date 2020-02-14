//
//  QRCodeDecoder.swift
//  qr
//
//  Created by Watanabe Toshinori on 2020/02/14.
//

import Foundation
import CoreImage

enum QRCodeDecoderError: LocalizedError {

    case decodeFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .decodeFailed(let path):
            return "Failed to decoding file: \(path)"
        }
    }
}

class QRCodeDecoder {

    static func decode(_ path: String) throws -> String {
        // Open image file
        let url: URL = {
            if path.hasPrefix("http://") || path.hasPrefix("https://") {
                if let url = URL(string: path) {
                    return url
                }
            }
            return URL(fileURLWithPath: path)
        }()
        
        guard let ciImage = CIImage(contentsOf: url) else {
            throw QRCodeDecoderError.decodeFailed(path)
        }

        // Detect QRcode
        let detector = CIDetector(ofType: CIDetectorTypeQRCode,
                                  context: nil,
                                  options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])

        let features = detector?.features(in: ciImage) as? [CIQRCodeFeature]
        return features?.reduce(into: "", { $0 += $1.messageString ?? "" }) ?? ""
    }

}
