import CoreImage
import AppKit

let filter = CIFilter(name: "CIQRCodeGenerator")!
filter.setValue("https://test-tiktok-qr.example/session/abc123".data(using: .utf8), forKey: "inputMessage")
filter.setValue("H", forKey: "inputCorrectionLevel")
let ciImage = filter.outputImage!
let scaleX = 400 / ciImage.extent.width
let scaled = ciImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleX))
let rep = NSBitmapImageRep(ciImage: scaled)
let pngData = rep.representation(using: .png, properties: [:])!
try! pngData.write(to: URL(fileURLWithPath: "/tmp/qrtest/test_qr.png"))
print("generated")
