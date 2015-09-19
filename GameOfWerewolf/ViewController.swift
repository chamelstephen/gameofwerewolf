//
//  ViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/03/13.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var playbutton:UIButton?
    @IBOutlet var pastbutton:UIButton?
    @IBOutlet var rulebutton:UIButton?
    @IBOutlet var settingbutton:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func play(){
        let playdevicealert = UIAlertController(title: "プレイ方法", message: "一つの端末でプレイしますか？\nそれとも複数の端末でプレイしますか？", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "複数の端末でプレイ", style: .Default) { (action) -> Void in
            
            
            
            
            print("複数端末でゲームを開始します")
        }
        
        let okAction = UIAlertAction(title: "一つの端末でプレイ", style: .Default) { (action) -> Void in
            let targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "navigationcontroller" )
            self.presentViewController( targetView as! UINavigationController, animated: true, completion: nil)

            
            print("単一端末でゲームを開始します")
        }
        
        let myAction_1 = UIAlertAction(title: "Hello", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction) in
            print("Hello")
        })
        
        playdevicealert.addAction(defaultAction)
        playdevicealert.addAction(okAction)
        
        presentViewController(playdevicealert, animated: true, completion: nil)
    }


}

