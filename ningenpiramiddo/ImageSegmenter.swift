//
//  ImageSegmenter.swift
//  iWant
//
//  Created by Kyoya Yamaguchi on 2024/03/28.
//

import Vision
import UIKit

enum ImageSegmenter {
    static func getForegroundImage(from image: UIImage) throws -> UIImage {
        guard let cgImage = image.cgImage else { throw "Unable to convert CGImage" }
        let request = VNGenerateForegroundInstanceMaskRequest()
        let handler = VNImageRequestHandler(cgImage: cgImage)
        try handler.perform([request])
        guard let result = request.results?.first else { throw "SegmentationError" }
        let mask = try result.generateMaskedImage(
            ofInstances: result.allInstances,
            from: handler,
            croppedToInstancesExtent: false
        )
        let maskedImage = UIImage(ciImage: CIImage(cvPixelBuffer: mask))
        return maskedImage
    }
}

extension String: LocalizedError {}
