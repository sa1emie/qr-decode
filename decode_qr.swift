import Vision
import AppKit
import Foundation

let args = CommandLine.arguments
guard args.count > 1 else { print("usage: decode_qr <image-path>"); exit(1) }
let path = args[1]

guard let image = NSImage(contentsOfFile: path),
      let cg = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
    print("could not read image: \(path)"); exit(1)
}

var req = DetectBarcodesRequest()
req.symbologies = [.qr]
let obs = try await req.perform(on: cg)
if obs.isEmpty { print("NO_QR_FOUND"); exit(2) }
for o in obs {
    print("QR: \(o.payloadString ?? "<nil>")")
}
