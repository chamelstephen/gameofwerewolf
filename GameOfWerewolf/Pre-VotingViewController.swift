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
    
    let playerData2 = NSUserDefaults.standardUserDefaults()
    var nameArray: [String] = []
    
    
    let appdelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameArray = appdelegate.voterarray
        
        if nameArray.count == 0{
            nameArray = playerData2.arrayForKey("player")! as! [String]
        }
        
        print("nameArray==>>\(nameArray)")
        print("nameArrray[0]==>>\(nameArray[0])")
        
        nameLabel.text = "\(nameArray[0])さん"
        
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
            let checkalert = UIAlertController(title: "プレイヤー確認", message: "あなたは\(nameArray[0])ですか？", preferredStyle: .Alert)
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: .Cancel, handler: {(action: UIAlertAction)
                -> Void in
                
                print("キャンセル")
            })
            
            let defaltAction: UIAlertAction = UIAlertAction(title: "はい", style: .Default, handler: {(action: UIAlertAction) -> Void in
                
                self.nameArray.removeAtIndex(0)
                self.appdelegate.voterarray = self.nameArray
                
                let targetView = self.storyboard?.instantiateViewControllerWithIdentifier("voting")
                targetView!.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
                self.presentViewController(targetView!, animated: true, completion: nil)
                
                
                print("オッケー")
            })
            
            checkalert.addAction(cancelAction)
            checkalert.addAction(defaltAction)
            
            presentViewController(checkalert, animated: true, completion: nil)
        }
}
