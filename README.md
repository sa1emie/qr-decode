# qr-decode

Two small Swift scripts that decode and generate QR codes using nothing but Apple's Vision framework. That's it. If you're on macOS 15.0+ and Xcode 16+, you already have everything they need. No Homebrew. No SPM packages. Everything runs with the tools already on your machine, which is exactly the point. Clone it, run it, done.

## Usage

```sh
swift decode_qr.swift <image-path>
```

It handles PNG, JPEG, HEIC, and TIFF, and when it finds a QR code it prints the payload:

```sh
$ swift decode_qr.swift qr.png
QR: https://example.com
```

When nothing is found, the script prints `NO_QR_FOUND` and exits with code `2`, so it composes cleanly into shell pipelines.

```sh
if swift decode_qr.sh screenshot.png | grep -q "^QR: "; then
  echo "decoded!"
fi
```

## Generating one (for testing)

`gen_qr.swift` is the companion script: feed it a string, get back a QR-encoded PNG at a reasonable size. It's handy for round-trip testing against the decoder.

## A note on the API

Most QR tutorials still use `VNRecognizeBarcodesRequest`, which Apple has deprecated. These scripts use its replacement, `DetectBarcodesRequest`, along with the async call pattern and `BarcodeObservation.payloadString` for reading values. That's the current API surface (macOS 15.0+), and if you have older Swift code that fails to compile against recent SDKs, this is probably why.

## License

MIT
