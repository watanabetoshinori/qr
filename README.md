# QR

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

QR is a Swift command line tool for encode/decode QRCode.

- [Features](#Features)
- [Getting Started](#getting-started)
    - [Requirements](#requirements)
    - [Installation](#installation)
- [Usage](#usage)
    - [Encode text to QRCode](#encode-text-to-qrcode)
    - [Decode image to QRCode](#decode-image-to-QRCode)
- [Author](#author)
- [License](#license)

## Features
- [x] Encode text to QRCode
- [x] Decode QRCode image path/URL to text

## Getting Started

### Requirements

* macOS 13.0+
* Xcode 11.2+
* Swift 5.1+

### Installation

**[Mint](https://github.com/yonaskolb/mint)**

```sh
mint install watanabetoshinori/qr
```

**Swift Package Manager**

```sh
git clone https://github.com/watanabetoshinori/qr.git
cd qr
swift run qr
```

## Usage

### Encode text to QRCode

Run qr with text:

```sh
qr text_to_encode
```

### Decode image to QRCode

Run qr with `--decode` option and file path:

```sh
qr --decode image_file_path_or_url
```

## Author

Watanabe Toshinori – toshinori_watanabe@tiny.blue

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
