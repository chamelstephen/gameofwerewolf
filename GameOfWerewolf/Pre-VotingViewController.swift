//
//  Pre-VotingViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/06/27.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class Pre_VotingViewController: UIViewController {
    
    @IBOutlet var faceImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    var nameArray: NSMutableArray! = []
    
    var appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("\(appdelegate.playerarray.count)")
        
        nameArray = appdelegate.playerarray
        nameLabel.text = "\(nameArray[0])さん"
        
        appdelegate.arraydefault = nameArray
        
        
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

    @IBAction func govote() {
            var checkalert = UIAlertController(title: "プレイヤー確認", message: "あなたは\(nameLabel.text)ですか？", preferredStyle: .Alert)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: .Cancel, handler: {(action: UIAlertAction)
                -> Void in
                
                print("キャンセル")
            })
            
            let defaltAction: UIAlertAction = UIAlertAction(title: "はい", style: .Default, handler: {(action: UIAlertAction) -> Void in
                
                var targetView = self.storyboard?.instantiateViewControllerWithIdentifier("voting")as! UIViewController
                targetView.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
                self.presentViewController(targetView, animated: true, completion: nil)
                
                
                print("オッケー")
            })
            
            checkalert.addAction(cancelAction)
            checkalert.addAction(defaltAction)
            
            presentViewController(checkalert, animated: true, completion: nil)
        }
}
