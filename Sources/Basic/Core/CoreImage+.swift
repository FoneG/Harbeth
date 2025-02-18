//
//  CoreImage+.swift
//  Harbeth
//
//  Created by 77。 on 2022/7/13.
//

import Foundation
import CoreImage

internal struct coreimage_ {
    
    static func drawingProcess(input texture: MTLTexture,
                               name: String,
                               filter: C7FilterProtocol) -> MTLTexture? {
        guard let cgImage = texture.toCGImage() else {
            return nil
        }
        let ciimage = CIImage.init(cgImage: cgImage)
        let cifiter = CIFilter.init(name: name)
        // 配置滤镜参数
        filter.coreImageSetupCIFilter(cifiter, input: cgImage)
        // 设置输入源
        cifiter?.setValue(ciimage, forKeyPath: kCIInputImageKey)
        guard let outputImage = cifiter?.outputImage else {
            return nil
        }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        let resultImage = C7Image(cgImage: cgImage)
        return resultImage.mt.toTexture()
    }
}
