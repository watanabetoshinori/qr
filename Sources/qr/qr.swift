//
//  command.swift
//  qr
//
//  Created by Watanabe Toshinori on 2020/02/14.
//

import Foundation
import TSCBasic
import ArgumentParser

@main
struct QR: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Encode text to QRcode / Decode QRcode image to text.",
        version: "1.0.0",
        subcommands: [Encode.self, Decode.self],
        defaultSubcommand: Encode.self)
}

extension QR {
    struct Encode: ParsableCommand {
        @Argument(help: "Text to encode.")
        var text: String

        mutating func run() {
            do {
                let path = try QRCodeEncoder.encode(text)
                print("Success!")
                let process = Process(arguments: ["/usr/bin/open", path])
                try process.launch()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    struct Decode: ParsableCommand {
        @Argument(help: "File or URL to decode.")
        var fileOrURL: String

        mutating func run() {
            do {
                let text = try QRCodeDecoder.decode(fileOrURL)
                print("Success!")
                print(text)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
