//
//  PunishingViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/06/27.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class PunishingViewController: UIViewController {
    
    var votedDataArray = [String]()//不要？
    
    var myVotedDataArray: [Int] = []//投票情報を前の画面から受け継ぐ
    var myVotedDataCopy: [Int] = []//得票数最大者を探し出すコードに使用
    var mypunishingString: String = ""//処刑者を表示
    var myPlayerItems: [String] = []//プレイヤー一覧
    
    let saveVotedData = NSUserDefaults.standardUserDefaults()//投票情報を引き出す
    
    var ope: Int = 0//平和村かどうか判別
    
    @IBOutlet var punishingplayerLabel: UILabel?//処刑者を表示
    
    @IBOutlet var punishView: UIImageView?//処刑エフェクトを表示

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)//navigationbarを非表示
        
        myVotedDataArray = saveVotedData.arrayForKey("votedIntPlayer")! as! [Int]//nsuserdefaultsからarrayに投票情報を代入
        print("投票結果：\(myVotedDataArray)")//確認
        
        var VotedDataMaxIndexArray: [Int] = []//得票最大のプレイヤーのインデックスを表示
        var VotedDataMaxInt: Int = 0//得票最大値を表示
        var MaxDataIntMinus: Int = 0//得票最大者を計算するために使用
        
        myVotedDataCopy = myVotedDataArray//copy array
        
        /*
        得票最大値と処刑者を探し出すwhile文
        */
        while (myVotedDataCopy.count > 0) {
            if (myVotedDataCopy[0] > VotedDataMaxInt) {
                VotedDataMaxInt = myVotedDataCopy[0]
                VotedDataMaxIndexArray.removeAll()
                VotedDataMaxIndexArray.append(MaxDataIntMinus)
                
            } else if (myVotedDataCopy[0] == VotedDataMaxInt) {
                VotedDataMaxIndexArray.append(MaxDataIntMinus)
                
            }
            myVotedDataCopy.removeFirst()
            MaxDataIntMinus = MaxDataIntMinus + 1
        }
        
        print("\(VotedDataMaxIndexArray)")//確認
        print("\(VotedDataMaxInt)")//確認
        
        myPlayerItems = saveVotedData.arrayForKey("allPlayers")! as! [String]
        
        if VotedDataMaxIndexArray.count == myPlayerItems.count {
            mypunishingString = "平和村でした〜〜"
            ope = 1
            
        } else if VotedDataMaxIndexArray.count == 5 {
            mypunishingString = "\(myPlayerItems[VotedDataMaxIndexArray[0]]),\(myPlayerItems[VotedDataMaxIndexArray[1]]),\(myPlayerItems[VotedDataMaxIndexArray[2]]),\(myPlayerItems[VotedDataMaxIndexArray[3]]),\(myPlayerItems[VotedDataMaxIndexArray[4]])"
            
        } else if VotedDataMaxIndexArray.count == 4 {
            mypunishingString = "\(myPlayerItems[VotedDataMaxIndexArray[0]]),\(myPlayerItems[VotedDataMaxIndexArray[1]]),\(myPlayerItems[VotedDataMaxIndexArray[2]]),\(myPlayerItems[VotedDataMaxIndexArray[3]])"
            
        } else if VotedDataMaxIndexArray.count == 3 {
            mypunishingString = "\(myPlayerItems[VotedDataMaxIndexArray[0]]),\(myPlayerItems[VotedDataMaxIndexArray[1]]),\(myPlayerItems[VotedDataMaxIndexArray[2]])"
            
        } else if VotedDataMaxIndexArray.count == 2 {
            mypunishingString = "\(myPlayerItems[VotedDataMaxIndexArray[0]]),\(myPlayerItems[VotedDataMaxIndexArray[1]])"
            
        } else {
            mypunishingString = "\(myPlayerItems[VotedDataMaxIndexArray[0]])"
        }
        
        punishingplayerLabel?.text = mypunishingString
        
        punishView?.hidden = true
        punishView?.image = UIImage(named: "punishview.png")
        
        /*
        if saveVotedData.arrayForKey("votedData") == nil {
            
            print("fale")
            
        } else {
            
            votedDataArray = saveVotedData.arrayForKey("votedData") as! [String]
            print("votedDataArray == \(votedDataArray)")
        }
        */
        //不要と思われるため、コメントアウト
    
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

    @IBAction func punish() {
        if ope == 0 {
            punishView?.hidden = false//エフェクトの表示
            
        }
        
    }
}
