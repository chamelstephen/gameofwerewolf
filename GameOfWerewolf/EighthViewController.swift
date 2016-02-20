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
    
    var savedData = NSUserDefaults.standardUserDefaults()
    
    var arraydefault: [String] = []
    var myRoleItems: [String] = []
    
    var myRole: String = ""
    var myName: String = ""//次の画面に引き渡すために使う
    
    @IBOutlet var roletext: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myRoleItems = savedData.arrayForKey("RolePlayerData")! as! [String]
        
        print("appdelegate.playerarray:\(appdelegate.playerarray.count)")
        
        arraydefault = appdelegate.arraydefault
        
        myRole = myRoleItems[myRoleItems.count - arraydefault.count]
        
        
        if myRole == "人狼" {
            roletext.text = "あなたは人狼です。\nとにかく殺されないようにしましょう。\nまた、間違えててるてるのプレイヤーを殺さないようにしましょう。"
        } else if myRole == "村人" {
            roletext.text = "あなたは村人です。\n人狼に殺されないように注意しましょう。\n市民チームに味方であることを疑われないようにすることも重要です。"
        } else if myRole == "怪盗" {
            roletext.text = "あなたは怪盗です。\n神出鬼没な変装術で他の役職に化けましょう。\nうまく他のプレイヤーを惑わせばチームを勝利に導けるでしょう。"
        } else if myRole == "占い師" {
            roletext.text = "あなたは占い師です。\n市民チームの勝利に最も重要な鍵を握る役職です。\n偽物の占い師と疑われないようにすることが肝心です。"
        } else if myRole == "てるてる" {
            roletext.text = "あなたはてるてるです。\n処刑願望に目覚めたあなたは死ぬことで幸福になれます。\n自分が処刑されるように立ち回りましょう。"
        }
        
        
        let myNameItems: [String] = savedData.arrayForKey("player")! as! [String]
        print("all players:\(myNameItems)")
        
        myName = myNameItems[myNameItems.count - arraydefault.count]
        print("my name:\(myName)")
        
        arraydefault.removeFirst()
        
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
            /*
            let targetView = self.storyboard!.instantiateViewControllerWithIdentifier( "roleprecheck" ) 
            self.presentViewController( targetView, animated: true, completion: nil)
            */
            //条件分岐で、次の画面遷移先を選ぶ
            if myRole == "てるてる" {
                let targetView = self.storyboard!.instantiateViewControllerWithIdentifier( "roleprecheck" )
                self.presentViewController( targetView, animated: true, completion: nil)
            } else if myRole == "村人" {
                let targetView = self.storyboard!.instantiateViewControllerWithIdentifier( "roleprecheck" )
                self.presentViewController( targetView, animated: true, completion: nil)
            } else {
                performSegueWithIdentifier("RoleWorking", sender: nil)
            }
            
            print("appdelegate.playerarray:\(appdelegate.playerarray.count)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "RoleWorking") {
            
            // SecondViewControllerクラスをインスタンス化してsegue（画面遷移）で値を渡せるようにバンドルする
            let roleworkingView : RoleWorkingViewController = segue.destinationViewController as! RoleWorkingViewController
            // secondView（バンドルされた変数）に受け取り用の変数を引数とし_paramを渡す（_paramには渡したい値）
            // この時SecondViewControllerにて受け取る同型の変数を用意しておかないとエラーになる
            roleworkingView.RoleString = myRole//役職を代入
            roleworkingView.NameString = myName//名前を代入
        }
    }
}
