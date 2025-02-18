//
//  C7Saturation.swift
//  ATMetalBand
//
//  Created by Condy on 2022/2/15.
//

import Foundation

/// 饱和度
public struct C7Saturation: C7FilterProtocol {
    
    /// Saturation refers to the brightness of the colors of images, which is adjusted by adjusting saturation.
    /// Saturation ranges from 0.0 to 2.0, in which 1.0 refers to the original figure.
    /// The greater the saturation is, the brighter the colors are. Otherwise, the more monotonous the colors are.
    public var saturation: Float = 1.0
    
    public var modifier: Modifier {
        return .compute(kernel: "C7Saturation")
    }
    
    public var factors: [Float] {
        return [saturation]
    }
    
    public init() { }
}
