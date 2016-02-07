//
//  ResultViewController.swift
//  OneNight
//
//  Created by kento on 2016/02/06.
//  Copyright © 2016年 Kento Ohara. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mytableview: UITableView!
    @IBOutlet var winingLabel: UILabel!
    
    var rolenumberArray: [Int] = []//役職ごとの人数を入れる
    var roleofplayerArray: [String] = []//インデックスのプレイヤーがその役職
    
    var worksections: [String] = ["人狼", "市民", "てるてる"]
    var werewolfitems: [String] = ["人狼"]
    var citizenitems: [String] = ["村人", "怪盗", "占い師"]
    var teruteruitems: [String] = ["てるてる"]
    
    var allroleitems: [String] = ["人狼", "村人", "怪盗", "占い師", "てるてる"]
    //var activeroleArray: [String] = []
    
    var werewolfteamArray: [String] = []
    var villagerteamArray: [String] = []
    var teruteruteamArray: [String] = []
    var villagerteamroleArray: [String] = []
    
    var werewolfteamVoteArray: [String] = []
    var villagerteamVoteArray: [String] = []
    var teruteruteamVoteArray: [String] = []
    
    var votedDataArray: [String] = []
    
    var punishedData: [Int] = []//処刑された人のインデックスを挿入
    var diedimagedisplay: [Bool] = []//バツじるしを表示するかしないかの判定
    
    var myPlayerItems: [String] = []//プレイヤーの名前
    let saveData = NSUserDefaults.standardUserDefaults()//諸々のNSUserDefaults

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "勝敗結果"
        
        mytableview.delegate = self
        mytableview.dataSource = self
        mytableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        
        myPlayerItems = saveData.arrayForKey("allPlayers")! as! [String]//プレイヤーの名前を取得して[String]に代入
        rolenumberArray = saveData.arrayForKey("RoleData")! as! [Int] //役職の人数を取得してNSArrayに代入
        roleofplayerArray = saveData.arrayForKey("RolePlayerData")! as! [String]//プレイヤーの役職を代入
        votedDataArray = saveData.arrayForKey("votedPlayer")! as! [String]//投票情報
        print("プレイヤー:\(myPlayerItems)")
        print("役職の人数:\(rolenumberArray)")
        print("\(roleofplayerArray)")
        print("\(votedDataArray)")
        
        let rolexib = UINib(nibName: "ResultTableViewCell", bundle: nil)
        mytableview.registerNib(rolexib, forCellReuseIdentifier: "ResultCell")
        
        //プレイヤーをチームごとに振り分け
        var continuingnumber: Int = 0
        
        while continuingnumber != myPlayerItems.count {
            if roleofplayerArray[continuingnumber] == "人狼" {
                werewolfteamArray.append(myPlayerItems[continuingnumber])
                werewolfteamVoteArray.append(votedDataArray[continuingnumber])
            } else if roleofplayerArray[continuingnumber] == "てるてる" {
                teruteruteamArray.append(myPlayerItems[continuingnumber])
                teruteruteamVoteArray.append(votedDataArray[continuingnumber])
            } else {
                villagerteamArray.append(myPlayerItems[continuingnumber])
                villagerteamroleArray.append(roleofplayerArray[continuingnumber])
                villagerteamVoteArray.append(votedDataArray[continuingnumber])
            }
            
            continuingnumber += 1 //plus 1
        
        }
        print("\(werewolfteamArray)")
        print("\(villagerteamArray)")
        print("\(teruteruteamArray)")
        print("\(villagerteamroleArray)")
        
        punishedData = saveData.arrayForKey("PunishedPlayerIndex")! as! [Int]//処刑された人のインデックス
        var punishedPlayer: [String] = []
        var copypunishedData: [Int] = punishedData
        
        while copypunishedData.count != 0 {
            punishedPlayer.append(myPlayerItems[copypunishedData[0]])
            copypunishedData.removeFirst()
        }
        print("\(punishedPlayer)")
        //punishedPlayerに処刑された人のプレイヤー名の配列を作成
        print(myPlayerItems)
        
        //punishedPlayerにてるてるのプレイヤーがいるか判定する関数をつくりまーす（2月6日)
        var teruteruope: Int = 0
        var teruterudiedope: Int = 0//diedimagedisplayに使用
        if (roleofplayerArray.indexOf("てるてる") != nil) {
            if punishedData.contains(roleofplayerArray.indexOf("てるてる")!) {
                teruteruope = 1//てるてるは処刑された
                teruterudiedope = 1
            }
        } else {
            teruteruope = 0//てるてるは処刑されてない(てるてるは存在しない)
        }
        
        //勝敗判定
        var contnumber: Int = 0
        var punishedwerewolf: [String] = []
        var punishedvillager: [String] = []
        
        if punishedPlayer.count == myPlayerItems.count {
            winingLabel.text = "It Was a Peaceful Village"
        } else if teruteruope == 1 {
            winingLabel.text = "Teruteru Team Won!!"
        } else {
            while contnumber != punishedData.count {
                if werewolfteamArray.contains(punishedPlayer[contnumber]) == true {
                    punishedwerewolf.append(punishedPlayer[contnumber])
                } else {
                    punishedvillager.append(punishedPlayer[contnumber])
                }
                contnumber += 1
            }
            
            if punishedvillager.count > punishedwerewolf.count {
                winingLabel?.text = "WereWolf Team Won!!"
            } else if punishedvillager.count < punishedwerewolf.count {
                winingLabel?.text = "Villager Team Won!!"
            } else {
                if villagerteamArray.count - punishedvillager.count > werewolfteamArray.count - punishedwerewolf.count {
                    winingLabel?.text = "Villager Team Won!!"
                } else if villagerteamArray.count - punishedvillager.count < werewolfteamArray.count - punishedwerewolf.count {
                    winingLabel?.text = "Werewolf Team Won!!"
                } else {
                    winingLabel?.text = "Werewolf Team Won!!"
                }
            }
        }
        print(winingLabel.text)
        
        //処刑された人にバツじるしを表示させる
        //処刑された人には.hidden==false、処刑されてない人には.hidden==tureをだす配列をつくろう
        //役職ごとにした
        //werewolfteamArrayとpunishedwerewolf
        //villagerteamArrayとpunishedvillager
        //teruteruteamArrayのプレイヤーがpunishedPlayerに存在するか
        //で、判定する
        var continuingcount: Int = werewolfteamArray.count
        var copypunishedwerewolf: [String] = punishedwerewolf
        while continuingcount != 0 {
            let ingcount: Int = werewolfteamArray.count - continuingcount
            if copypunishedwerewolf.isEmpty == true {
                diedimagedisplay.append(true)//処刑された人狼はいない
            } else if werewolfteamArray[ingcount] == copypunishedwerewolf[0] {
                diedimagedisplay.append(false)//処刑された人狼がいた
                copypunishedwerewolf.removeFirst()
            } else {
                diedimagedisplay.append(true)//[ingcount]は処刑されていなかった
            }
            continuingcount -= 1
        }
        print("\(diedimagedisplay)")
        
        continuingcount = villagerteamArray.count
        var copypunishedvillager: [String] = punishedvillager
        while continuingcount != 0 {
            let ingcount: Int = villagerteamArray.count - continuingcount
            if copypunishedvillager.isEmpty == true {
                diedimagedisplay.append(true)
            } else if villagerteamArray[ingcount] == copypunishedvillager[0] {
                diedimagedisplay.append(false)
                copypunishedvillager.removeFirst()
            } else {
                diedimagedisplay.append(true)
            }
            continuingcount -= 1
        }
        print("\(diedimagedisplay)")
        
        if teruteruteamArray.isEmpty == false {
            if teruterudiedope == 1 {
                diedimagedisplay.append(false)//てるてるは処刑された
            } else {
                diedimagedisplay.append(true)//てるてるは処刑されなかった
            }
        } else {
            diedimagedisplay.append(true)//てるてるは存在しない
        }
        print("\(diedimagedisplay)")
        
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

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if rolenumberArray[4] == 0{
            return 2
        } else {
            return 3
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return worksections [section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return werewolfteamArray.count
        } else if section == 1 {
            return villagerteamArray.count
        } else if section == 2 {
            return teruteruteamArray.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell", forIndexPath: indexPath) as! ResultTableViewCell
        
        if indexPath.section == 0 {
            cell.roleLabel!.text = "役職:\(allroleitems[0])"
        } else if indexPath.section == 1 {
            cell.roleLabel!.text = "役職:\(villagerteamroleArray[indexPath.row])"
        } else if indexPath.section == 2 {
            cell.roleLabel!.text = "役職:\(allroleitems[4])"
        }
        //役職名を表示
        
        if indexPath.section == 0 {
            cell.nameLabel!.text = "\(werewolfteamArray[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.nameLabel!.text = "\(villagerteamArray[indexPath.row])"
        } else if indexPath.section == 2 {
            cell.nameLabel!.text = "\(teruteruteamArray[indexPath.row])"
        }
        
        if indexPath.section == 0 {
            cell.voteLabel!.text = "\(werewolfteamVoteArray[indexPath.row])に投票しました"
        } else if indexPath.section == 1 {
            cell.voteLabel!.text = "\(villagerteamVoteArray[indexPath.row])に投票しました"
        } else if indexPath.section == 2 {
            cell.voteLabel!.text = "\(teruteruteamVoteArray[indexPath.row])に投票しました"
        }
        
        if indexPath.section == 0 {
            cell.diedImageView!.hidden = diedimagedisplay[indexPath.row]
        } else if indexPath.section == 1 {
            cell.diedImageView!.hidden = diedimagedisplay[indexPath.row + rolenumberArray[0]]
        } else if indexPath.section == 2 {
            if winingLabel.text == "Teruteru Team Won!!" {
                cell.diedImageView!.hidden = false//てるてるが勝ったときは処刑されたとき
            } else {
                cell.diedImageView!.hidden = true
            }
        }
        return cell
    }
}
