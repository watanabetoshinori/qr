//
//  QRCodeEncoder.swift
//  qr
//
//  Created by Watanabe Toshinori on 2020/02/14.
//

import Foundation
import Basic
import CoreImage

enum QRCodeEncoderError: LocalizedError {

    case encodeFailed(String)
    
    var errorDescription: String? {
        switch self {
        case .encodeFailed(let text):
            return "Failed to encoding text: \(text)"
        }
    }
}

class QRCodeEncoder {

    static func encode(_ string: String) throws -> String {
        do {
            // Generate QRcode
            let filter = CIFilter(name: "CIQRCodeGenerator")!
            filter.setValue(string.data(using: .utf8), forKey: "inputMessage")
            guard let ciImage = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 5, y: 5)) else {
                throw QRCodeEncoderError.encodeFailed(string)
            }

            // Save QRcode image
            let file = try TemporaryFile(suffix: ".png", deleteOnClose: false)
            let context = CIContext()
            try context.writePNGRepresentation(of: ciImage,
                                               to: file.path.asURL,
                                               format: .RGBA8,
                                               colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!)

            return file.path.asURL.absoluteString

        } catch {
            throw QRCodeEncoderError.encodeFailed(string)
        }
    }

}
