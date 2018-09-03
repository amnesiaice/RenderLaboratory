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
    
    private lazy var _view:MTKView=viewCreate();
    
    var _renderer:RLRenderer?;

    override func loadView() {
        self.view=_view;
    }
//    init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    //    required init?(coder: NSCoder) {
//        //fatalError()
//    }
    override func viewDidLoad() {
       
        super.viewDidLoad();
        // Do any additional setup after loading the view.

        //self.view.addSubview(_view!);
    }
    func viewCreate()->MTKView {
        let funView=MTKView(frame: NSMakeRect(0,0,800,600), device: nil);
        funView.device=MTLCreateSystemDefaultDevice();
        if funView.device == nil
        {
            NSLog("Metal is not supported on this device");
            return funView;
        }
        _renderer = RLRenderer().initWithMetalKitView(mtkView: funView);
        if _renderer==nil
        {
            NSLog("Renderer failed initialization" );
            return funView;
        }
        
        funView.delegate = _renderer;
        funView.preferredFramesPerSecond  =  60;
        return funView;
    }

//    override var representedObject: Any? {
//        didSet {
//        // Update the view, if already loaded.
//        }
//    }


}

