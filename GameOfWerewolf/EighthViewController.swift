//
//  EighthViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/06/27.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class EighthViewController: UIViewController {
    
    var appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var arraydefault: NSMutableArray = []
    
    @IBOutlet var roletext: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("appdelegate.playerarray:\(appdelegate.playerarray.count)")
        
        arraydefault = appdelegate.arraydefault
        arraydefault.removeObjectAtIndex(0)
        
        print("appdelegate.playerarray:\(appdelegate.playerarray.count)")
        
        if arraydefault.count == 0 {
            
        } else {
            appdelegate.arraydefault = arraydefault
            print("次のプレイヤー:\(arraydefault[0])")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func next() {
        if arraydefault.count == 0{
            let targetView = self.storyboard!.instantiateViewControllerWithIdentifier( "gamestart" ) 
            self.presentViewController( targetView, animated: true, completion: nil)
            
            print("appdelegate.playerarray:\(appdelegate.playerarray.count)")
        } else {
            let targetView = self.storyboard!.instantiateViewControllerWithIdentifier( "roleprecheck" ) 
            self.presentViewController( targetView, animated: true, completion: nil)
            
            print("appdelegate.playerarray:\(appdelegate.playerarray.count)")
        }
    }
}
