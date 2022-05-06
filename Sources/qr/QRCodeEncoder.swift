//
//  QRCodeEncoder.swift
//  qr
//
//  Created by Watanabe Toshinori on 2020/02/14.
//

import Foundation
import TSCBasic
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

            var filePath = ""
            // Save QRcode image
            try withTemporaryFile(suffix: ".png") { tempFile, cleanup in
                let context = CIContext()
                try context.writePNGRepresentation(of: ciImage,
                                                   to: tempFile.path.asURL,
                                                   format: .RGBA8,
                                                   colorSpace: CGColorSpace(name: CGColorSpace.sRGB)!)

                filePath = tempFile.path.asURL.absoluteString
            }
            return filePath
        } catch {
            throw QRCodeEncoderError.encodeFailed(string)
        }
    }

}
