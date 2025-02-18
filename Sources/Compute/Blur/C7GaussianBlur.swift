//
//  C7GaussianBlur.swift
//  Harbeth
//
//  Created by Condy on 2022/3/2.
//

import Foundation

public struct C7GaussianBlur: C7FilterProtocol {
    
    public var blurRadius: Float = 1
    
    public var modifier: Modifier {
        return .compute(kernel: "C7GaussianBlur")
    }
    
    public var factors: [Float] {
        return [blurRadius]
    }
    
    public init() { }
}
