//
//  main.swift
//  qr
//
//  Created by Watanabe Toshinori on 2020/02/14.
//

import Foundation
import Basic
import SPMUtility

do {
    // Argument definition
    let parser = ArgumentParser(commandName: "qr",
                                usage: "[<text> | --decode (<file> | <url>)]",
                                overview: "Encode text to QRcode / Decode QRcode image to text.")
    let textOrImage = parser.add(positional: "text", kind: [String].self)
    let decodeOption = parser.add(option: "--decode", shortName: "-d", kind: Bool.self)
    
    // Parse arguments
    let input = Array(CommandLine.arguments.dropFirst())
    let arguments = try parser.parse(input)

    let isDecode = arguments.get(decodeOption) ?? false
    let value = arguments.get(textOrImage)?.joined(separator: " ") ?? ""

    if isDecode {
        // Decode
        let text = try QRCodeDecoder.decode(value)
        print("Success!")
        print(text)

    } else {
        // Encode
        let path = try QRCodeEncoder.encode(value)
        print("Success!")
        let process = Process(arguments: ["/usr/bin/open", path])
        try process.launch()
    }

} catch ArgumentParserError.expectedArguments(_, let array) {
    print("Missing arguments: \(array.joined()).")

} catch {
    print(error.localizedDescription)
}
