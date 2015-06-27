//
//  SeventhViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/06/27.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class SeventhViewController: UIViewController {
    
    @IBOutlet var rolelabel: UILabel!
    @IBOutlet var faceView: UIImageView!
    
    
    var appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        rolelabel.text = "あなたは人狼です"
        
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

}
