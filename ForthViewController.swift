//
//  ForthViewController.swift
//  GameOfWerewolf
//
//  Created by kento on 2015/04/18.
//  Copyright (c) 2015年 Kento Ohara. All rights reserved.
//

import UIKit

class ForthViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var worktableview:UITableView!
    var countplayer: Int = 0
    
    var werewolfnumber: Int = 1
    var citizennumber: Int = 0
    var kaitounumber: Int = 1
    var uranainumber: Int = 1
    var teruterunumber: Int = 0
    
    var worksections: [String] = ["人狼", "市民", "てるてる"]
    var werewolfitems: [String] = ["人狼"]
    var citizenitems: [String] = ["村人", "怪盗", "占い師"]
    var teruteruitems: [String] = ["てるてる"]
    
    var werewolfnumberitems: NSArray = []
    var citizennumberitems: NSArray = []
    var teruterunumberitems: NSArray = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("プレイヤー人数:\(countplayer)")
        
        worktableview.delegate=self
        worktableview.dataSource=self
        worktableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "WorkCell")
        
        citizennumber = countplayer - (werewolfnumber + kaitounumber + uranainumber + teruterunumber)
        
        werewolfnumberitems = ["\(werewolfnumber)"]
        citizennumberitems = ["\(citizennumber)", "\(kaitounumber)", "\(uranainumber)"]
        teruterunumberitems = ["\(teruterunumber)"]
        
        print("\(werewolfnumberitems[0])")
        print("\(teruterunumberitems[0])")
        
        let rolexib = UINib(nibName: "RolenumberTableViewCell", bundle: nil)
        worktableview.registerNib(rolexib, forCellReuseIdentifier: "WorkCell")
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
        return 3
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return worksections [section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return werewolfitems.count
        } else if section == 1 {
            return citizenitems.count
        } else if section == 2 {
            return teruteruitems.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("WorkCell", forIndexPath: indexPath) as! RolenumberTableViewCell
        
        
        if indexPath.section == 0 {
            cell.roleLabel!.text = "\(werewolfitems[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.roleLabel!.text = "\(citizenitems[indexPath.row])"
        } else if indexPath.section == 2 {
            cell.roleLabel!.text = "\(teruteruitems[indexPath.row])"
        }
        
        
        if indexPath.section == 0 {
            cell.workernumberlabel!.text = "\(werewolfnumberitems[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.workernumberlabel!.text = "\(citizennumberitems[indexPath.row])"
        } else if indexPath.section == 2 {
            cell.workernumberlabel!.text = "\(teruterunumberitems[indexPath.row])"
        }
        
        return cell
    }
    
    
}
