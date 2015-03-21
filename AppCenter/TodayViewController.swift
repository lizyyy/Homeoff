//
//  TodayViewController.swift
//  XebiaBlogRSSWidget
//
//  Created by Lammert Westerhoff on 09/09/14.
//  Copyright (c) 2014 Lammert Westerhoff. All rights reserved.
//

import UIKit
import NotificationCenter
class TodayViewController: UITableViewController, NCWidgetProviding {
    var plistArray:NSArray?
    var wLine :Float = 0
    var wRow = 4// 一行5条
    var ct:Int?
    var btnWidth:CGFloat = 46
    var btnHeight:CGFloat = 46
    override func viewDidLoad() {
        super.viewDidLoad()
        //data
        let path = NSBundle.mainBundle().pathForResource("WidgetData", ofType: "plist")
        plistArray = NSArray(contentsOfFile: path!)
        //
        ct = plistArray?.count
        wLine  = ceil(  Float(ct!)/Float(wRow)  )
        preferredContentSize = CGSizeMake(CGFloat(0), CGFloat(wLine) * 68)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ context in
            }, completion: nil)
    }
    
    // MARK: Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(wLine)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 68
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellItem", forIndexPath: indexPath) as TodayCell
        var row =  indexPath.row
        for i in 0 ..< Int(wRow) {
            var ii  = row * wRow + i
            if (  ii <  ct) {
                var selBtn = UIButton(frame: CGRectMake(CGFloat(i)*btnWidth+CGFloat(i*20), 10, btnWidth, btnHeight))
                selBtn.tag = ii
                if plistArray![ii]["type"] as String == "text" {
                    selBtn.setTitle( (plistArray![ii]["name"] as String), forState: UIControlState.Normal)
                }else{
                    //圆角
                    var l = selBtn.layer
                    l.masksToBounds = true
                    l.cornerRadius = 12
                    var image = UIImage(named:(plistArray![ii]["image"] as String))
                    selBtn.setBackgroundImage( image, forState: UIControlState.Normal)
                }
                selBtn.addTarget(self, action: "sel:", forControlEvents: UIControlEvents.TouchUpInside)
                cell.addSubview(selBtn)
            }
        }
        return cell
    }
    
    func sel(sender: UIButton){
        var url =  plistArray![sender.tag]["url"] as String
        self.extensionContext?.openURL(NSURL(string: url)!, completionHandler: nil)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        completionHandler(NCUpdateResult.NoData)
    }
    
}

extension UIButton {
    func createShadow(color:UIColor, radius: CGFloat){
        let backGroundColor = CALayer()
        backGroundColor.backgroundColor = layer.backgroundColor
        backGroundColor.cornerRadius = radius
        backGroundColor.frame = CGRectMake(0, 0, CGRectGetWidth(layer.frame), CGRectGetHeight(layer.frame));
        layer.insertSublayer(backGroundColor, atIndex:0)
        
        let bottomShadow = CALayer()
        bottomShadow.backgroundColor = color.CGColor
        bottomShadow.cornerRadius = radius
        bottomShadow.frame = CGRectMake(0, 4, CGRectGetWidth(layer.frame), CGRectGetHeight(layer.frame));
        layer.insertSublayer(bottomShadow, atIndex:0)
    }
}

 