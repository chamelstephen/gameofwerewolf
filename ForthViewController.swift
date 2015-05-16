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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("プレイヤー人数:\(countplayer)")
        
        worktableview.delegate=self
        worktableview.dataSource=self
        worktableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "WorkCell")
        
        citizennumber = countplayer - (werewolfnumber + kaitounumber + uranainumber + teruterunumber)
        
        var werewolfnumberitems = ["\(werewolfnumber)"]
        var citizennumberitems = ["\(citizennumber)", "\(kaitounumber)", "\(uranainumber)"]
        var teruterunumberitems = ["\(teruterunumber)"]
        
        println("\(werewolfnumberitems[0])")
        println("\(teruterunumberitems[0])")
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
        var cell = tableView.dequeueReusableCellWithIdentifier("WorkCell", forIndexPath: indexPath) as! UITableViewCell
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "\(werewolfitems[indexPath.row])"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "\(citizenitems[indexPath.row])"
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "\(teruteruitems[indexPath.row])"
        }
        
        /*
        var playerchangestepper = UIStepper(target: self, action:"stepperchanged:")
        playerchangestepper.center = CGPointMake(280, 10)
        
        playerchangestepper.stepValue = 1
        if cell.textLabel?.text == "人狼" {
            playerchangestepper.minimumValue = 1
            playerchangestepper.maximumValue = 5
            playerchangestepper.value = 2
        } else if cell.textLabel?.text == "村人" {
            playerchangestepper.minimumValue = 0
            playerchangestepper.maximumValue = 10
            playerchangestepper.value = 1
        } else if cell.textLabel?.text == "怪盗" {
            playerchangestepper.minimumValue = 0
            playerchangestepper.maximumValue = 1
            playerchangestepper.value = 1
        } else if cell.textLabel?.text == "占い師" {
            playerchangestepper.minimumValue = 0
            playerchangestepper.maximumValue = 10
            playerchangestepper.value = 1
        } else if cell.textLabel?.text == "てるてる" {
            playerchangestepper.minimumValue = 0
            playerchangestepper.maximumValue = 1
            playerchangestepper.value = 0
        }
        
        cell.contentView.addSubview(playerchangestepper)
        */

        /*
        var workernumberlabel = UILabel(frame: CGRectMake(265, 42.5, 15, 15))
        if indexPath.section == 0 {
            workernumberlabel.text = "\(numberitems[indexPath.row])"
        } else if indexPath.section == 1 && indexPath.row == 0 {
            workernumberlabel.text = "\(numberitems[indexPath.row])"
        } else if indexPath.section == 1 && indexPath.row == 1 {
            workernumberlabel.text = "\(kaitounumber)"
        } else if indexPath.section == 1 && indexPath.row == 2 {
            workernumberlabel.text = "\(uranainumber)"
        } else if indexPath.section == 2 && indexPath.row == 0 {
            workernumberlabel.text = "\(teruterunumber)"
        }
        
        cell.contentView.addSubview(workernumberlabel)
        */
        
        return cell
    }
    
    func stepperchanged(sender: UIStepper) {
        /*
        if cell.textLabel?.text == "人狼" {
            werewolfnumber = werewolfnumber + 1
            workernumberlabel.text = "\(werewolfnumber)"
        } else if cell.textLabel?.text == "村人" {
            workernumberlabel.text = "\(citizennumber)"
        } else if cell.textLabel?.text == "怪盗" {
            workernumberlabel.text = "\(kaitounumber)"
        } else if cell.textLabel?.text == "占い師" {
            workernumberlabel.text = "\(uranainumber)"
        } else if cell.textLabel?.text == "てるてる" {
            workernumberlabel.text = "\(teruterunumber)"
        }
*/
    }

}
