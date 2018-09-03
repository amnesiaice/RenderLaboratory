//
//  Renderer.swift
//  RenderLaboratory
//
//  Created by Amn Ice on 2018/8/15.
//  Copyright © 2018 Amn Ice. All rights reserved.
//

import Foundation
import Cocoa
import MetalKit


class RLRenderer : NSObject,MTKViewDelegate   {
    var _device         :   MTLDevice?
    var _commandQueue   :   MTLCommandQueue?
    var _pipelineState  :   MTLRenderPipelineState?
    var _viewportSize   :   vector_uint2 = uint2(800,600);

    struct Color {
        var red:Double = 0;
        var green:Double = 0;
        var blue:Double = 0;
        var alpha:Double = 0;
        
    };
    
    func initWithMetalKitView(mtkView:MTKView)->RLRenderer {
        _device         =   mtkView.device;
        _commandQueue   =   _device?.makeCommandQueue();
        return self
    }
    
    //Since we cannot put static variable into a function, so I have to put it before the function
    static var growing:Bool=true;
    static var primaryChannel   :   NSInteger=0;
    static var colorChannels    :   [Double]=[1.0,0.0,0.0,1.0]
    static func makeFancyColor() -> Color {
        let DynamicColorRate : Double = 0.015;
        
        if(growing)
        {
            let DynamicChannelIndex:NSInteger = (primaryChannel+1)%3;
            colorChannels[DynamicChannelIndex] += DynamicColorRate;
            if(colorChannels[DynamicChannelIndex] >= 1.0)
            {
                growing         = false;
                primaryChannel  = DynamicChannelIndex;
            }
        }
        else
        {
            let DynamicChannelIndex:NSInteger = (primaryChannel+2)%3;
            colorChannels[DynamicChannelIndex] -= DynamicColorRate;
            if(colorChannels[DynamicChannelIndex] <= 0.0)
            {
                growing         = true;
            }
        }
        
        var color=Color();
        color.red    =   colorChannels[0];
        color.green  =   colorChannels[1];
        color.blue   =   colorChannels[2];
        color.alpha  =   colorChannels[3];
        
        return color;
    }
    
    func draw(in view:MTKView)
    {
        let color : Color = RLRenderer.makeFancyColor();
        view.clearColor = MTLClearColor(red:color.red,green:color.green,blue:color.blue,alpha:color.alpha);
        let commandBuffer : MTLCommandBuffer = (_commandQueue?.makeCommandBuffer())!;
        commandBuffer.label="MyCommand";
        
        let renderPassDescriptor : MTLRenderPassDescriptor? = view.currentRenderPassDescriptor;
        
         if(renderPassDescriptor != nil)
         {
            let renderEncoder : MTLRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor!)!;
            renderEncoder.label="MyRenderEncoder";
            
            renderEncoder.endEncoding();
            commandBuffer.present(view.currentDrawable!);
        }
        
        commandBuffer.commit();

        
        
    }
    func mtkView(_ view:MTKView,drawableSizeWillChange size:CGSize)
    {
        _viewportSize.x = uint(size.width);
        _viewportSize.y = uint(size.height);
    }
    
}





