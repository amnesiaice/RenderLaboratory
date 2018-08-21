//
//  ViewController.swift
//  RenderLaboratory
//
//  Created by Amn Ice on 2018/8/15.
//  Copyright © 2018 Amn Ice. All rights reserved.
//

import Cocoa

import MetalKit


class ViewController: NSViewController {
    
    var _view:MTKView?;
    
    var _renderer:RLRenderer?;
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Do any additional setup after loading the view.
        _view = MTKView();
//        _view = self.view as MTKView;
        _view?.device=MTLCreateSystemDefaultDevice();
        if _view!.device == nil
        {
            NSLog("Metal is not supported on this device");
            return;
        }
        _renderer = RLRenderer().initWithMetalKitView(mtkView: _view!);
        if _renderer==nil
        {
            NSLog("Renderer failed initialization" );
            return;
        }
        _view?.delegate = _renderer;
        _view?.preferredFramesPerSecond  =  60;
        self.view = _view!;
    }

//    override var representedObject: Any? {
//        didSet {
//        // Update the view, if already loaded.
//        }
//    }


}

