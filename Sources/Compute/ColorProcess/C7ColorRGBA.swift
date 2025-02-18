//
//  C7ColorRGBA.swift
//  ATMetalBand
//
//  Created by Condy on 2022/2/15.
//

import Foundation

public struct C7ColorRGBA: C7FilterProtocol {

    /// Modify the value of color single channel, `1` keeps the source channel color, `>1` adds red pigment, `<1` reduces red pigment
    public var red:   Float = 1
    public var green: Float = 1
    public var blue:  Float = 1
    public var alpha: Float = 1
    /// Transparent colors are not processed, Will directly modify the overall color scheme
    public var color: C7Color = C7EmptyColor {
        didSet {
            color.mt.toRGBA(red: &red, green: &green, blue: &blue, alpha: &alpha)
        }
    }
    
    public var modifier: Modifier {
        return .compute(kernel: "C7ColorRGBA")
    }
    
    public var factors: [Float] {
        return [red, green, blue, alpha]
    }
    
    public init() { }
}
