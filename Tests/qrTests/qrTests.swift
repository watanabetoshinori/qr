//
//  qrTests.swift
//  qrTests
//
//  Created by Watanabe Toshinori on 2020/02/14.
//

import XCTest
import class Foundation.Bundle

final class qrTests: XCTestCase {
    
    /// Returns path to the built products directory.
    var productsDirectory: URL {
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
    }
    
    // MARK: - Tests

    func testEncodeWithoutText() throws {
        let output = try runBinary()
        XCTAssertEqual(output, "Missing arguments: text.\n")
    }

    func testDecodeWithoutPath() throws {
        let output = try runBinary(with: ["--decode"])
        XCTAssertEqual(output, "Missing arguments: text.\n")
    }

    func testUnknownArguments() throws {
        let output = try runBinary(with: ["--encode"])
        XCTAssertEqual(output, "unknown option --encode; use --help to list available options\nDid you mean --decode?\n")
    }

    // MARK: - Helpers
    
    private func runBinary(with arguments: [String] = []) throws -> String? {
        let binary = productsDirectory.appendingPathComponent("qr")

        let process = Process()
        process.executableURL = binary
        process.arguments = arguments

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        return output
    }

}
