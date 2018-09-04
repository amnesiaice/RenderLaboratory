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
        let view=MTKView(frame: NSMakeRect(0,0,800,600), device: nil);
        view.device=MTLCreateSystemDefaultDevice();
        if view.device == nil
        {
            NSLog("Metal is not supported on this device");
            return view;
        }
        _renderer = RLRenderer().initWithMetalKitView(mtkView: view);
        if _renderer==nil
        {
            NSLog("Renderer failed initialization" );
            return view;
        }
        
        view.delegate = _renderer;
        view.preferredFramesPerSecond  =  60;
        return view;
    }

//    override var representedObject: Any? {
//        didSet {
//        // Update the view, if already loaded.
//        }
//    }


}

