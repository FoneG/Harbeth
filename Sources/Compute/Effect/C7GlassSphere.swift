//
//  C7GlassSphere.swift
//  ATMetalBand
//
//  Created by Condy on 2022/2/16.
//

import Foundation

public struct C7GlassSphere: C7FilterProtocol {
    
    public var radius: Float = 0.25
    public var refractiveIndex: Float = 0.71
    public var aspectRatio: Float = 1
    public var center: C7Point2D = C7Point2DCenter
    
    public var modifier: Modifier {
        return .compute(kernel: "C7GlassSphere")
    }
    
    public var factors: [Float] {
        return [radius, refractiveIndex, aspectRatio, center.x, center.y]
    }
    
    public init() { }
}
