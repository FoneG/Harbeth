//
//  C7Nostalgic.swift
//  Harbeth
//
//  Created by Condy on 2022/3/3.
//

import Foundation

/// 怀旧滤镜
public struct C7Nostalgic: C7FilterProtocol {
    
    /// The degree to which tan replaces normal image color, from 0.0 to 1.0
    public var intensity: Float = 1.0
    
    public var modifier: Modifier {
        return .compute(kernel: "C7Nostalgic")
    }
    
    public var factors: [Float] {
        return [intensity]
    }
    
    public init() { }
}
