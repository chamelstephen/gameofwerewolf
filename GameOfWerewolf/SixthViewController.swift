//
//  SixthViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/05/16.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class SixthViewController: UIViewController {
    
    @IBOutlet var faceImageView: UIImageView!
    @IBOutlet var nameLabelView: UILabel!
    
    var playername: NSString = ""
    
    
    var appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        playername = appdelegate.arraydefault[0] as! NSString
        print("プレイヤー名:\(playername)")
        
        nameLabelView.text = "\(playername)さん"
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
    
    @IBAction func playercheck() {
        var checkalert = UIAlertController(title: "プレイヤー確認", message: "あなたは\(playername)さんですか？", preferredStyle: .Alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: .Cancel, handler: {(action: UIAlertAction)
            -> Void in
            
            print("キャンセル")
        })
        
        let defaltAction: UIAlertAction = UIAlertAction(title: "はい", style: .Default, handler: {(action: UIAlertAction) -> Void in
            
            var targetView = self.storyboard?.instantiateViewControllerWithIdentifier("rolecheck")as! UIViewController
            targetView.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
            self.presentViewController(targetView, animated: true, completion: nil)
            
            
            print("オッケー")
        })
        
        checkalert.addAction(cancelAction)
        checkalert.addAction(defaltAction)
        
        presentViewController(checkalert, animated: true, completion: nil)
    }

}
//画像の設定と役職の割り振り
