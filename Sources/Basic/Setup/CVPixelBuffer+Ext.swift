//
//  CVPixelBuffer+Ext.swift
//  Harbeth
//
//  Created by Condy on 2022/2/28.
//

import Foundation
import CoreVideo
import MetalKit

extension CVPixelBuffer: C7Compatible { }

extension Queen where Base: CVPixelBuffer {
    
    /// Convert cached pixel objects into textures that can be used for camera capture and video frame filters
    /// - parameter textureCache: Global textureCache.
    /// - Returns: textures
    public func convert2MTLTexture(textureCache: CVMetalTextureCache?) -> MTLTexture? {
        guard let textureCache = textureCache else {
            return nil
        }
        #if !targetEnvironment(simulator)
        var cvmTexture: CVMetalTexture?
        CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault,
                                                  textureCache,
                                                  self.base,
                                                  nil,
                                                  MTLPixelFormat.bgra8Unorm,
                                                  CVPixelBufferGetWidth(self.base),
                                                  CVPixelBufferGetHeight(self.base),
                                                  0,
                                                  &cvmTexture)
        if let cvmTexture = cvmTexture, let texture = CVMetalTextureGetTexture(cvmTexture) {
            return texture
        }
        #endif
        return nil
    }
    
    public func convert2C7Image(textureCache: CVMetalTextureCache?, filters: [C7FilterProtocol]) -> C7Image? {
        guard var texture = convert2MTLTexture(textureCache: textureCache) else {
            return nil
        }
        // 运算符组合滤镜效果，生成纹理
        filters.forEach { texture = texture ->> $0 }
        return texture.toImage()
    }
}
