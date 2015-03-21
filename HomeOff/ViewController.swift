//
//  ViewController.swift
//  HomeOff
//
//  Created by leeey on 14/12/5.
//  Copyright (c) 2014年 leeey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //data
        let path = NSBundle.mainBundle().pathForResource("WidgetData", ofType: "plist")
        var plistArray = NSArray(contentsOfFile: path!)
        println(plistArray)
        abort()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

