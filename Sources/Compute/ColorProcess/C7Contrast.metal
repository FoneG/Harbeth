//
//  C7Contrast.metal
//  ATMetalBand
//
//  Created by Condy on 2022/2/15.
//

#include <metal_stdlib>
using namespace metal;

kernel void C7Contrast(texture2d<half, access::write> outputTexture [[texture(0)]],
                       texture2d<half, access::read> inputTexture [[texture(1)]],
                       constant float *contrast [[buffer(0)]],
                       uint2 grid [[thread_position_in_grid]]) {
    const half4 inColor = inputTexture.read(grid);
    
    const half4 outColor(((inColor.rgb - half3(0.5h)) * half3(*contrast) + half3(0.5h)), inColor.a);
    
    outputTexture.write(outColor, grid);
}
