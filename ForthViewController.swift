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
    
    var worksections : [String] = ["人狼", "市民", "てるてる"]
    var werewolfitems : [String] = ["人狼", "狂人", "きつね"]
    var citizenitems : [String] = ["市民", "ガードマン", "占い師", "霊媒師"]
    var teruteruitems : [String] = ["てるてる"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        worktableview.delegate=self
        worktableview.dataSource=self
        worktableview.registerClass(UITableViewCell.self, forCellReuseIdentifier: "WorkCell")
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
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
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
        
        var playerchangestepper = UIStepper(target: self, action:"stepperchanged:")
        playerchangestepper.center = CGPointMake(280, 10)
        if indexPath.section == 0 && indexPath.row == 0 {
            playerchangestepper.minimumValue = 1
            playerchangestepper.maximumValue = 2
        } else if indexPath.section == 0 && indexPath.row == 1 {
            playerchangestepper.minimumValue = 1
            playerchangestepper.maximumValue = 1
        } else if indexPath.section == 0 && indexPath.row == 2 {
            playerchangestepper.minimumValue = 1
            playerchangestepper.maximumValue = 1
        } else if indexPath.section == 1 && indexPath.row == 0 {
            playerchangestepper.minimumValue = 0
            playerchangestepper.maximumValue = 2
        } else if indexPath.section == 1 && indexPath.row == 1 {
            playerchangestepper.minimumValue = 0
            playerchangestepper.maximumValue = 2
        } else if indexPath.section == 1 && indexPath.row == 2 {
            playerchangestepper.minimumValue = 0
            playerchangestepper.maximumValue = 2
        } 
        
        cell.contentView.addSubview(playerchangestepper)
        
        return cell
    }
    
    func stepperchanged(sender: UIStepper) {
        
    }

}
