//
//  RoleChangingViewController.swift
//  OneNight
//
//  Created by kento on 2016/03/05.
//  Copyright © 2016年 Kento Ohara. All rights reserved.
//

import UIKit

class RoleChangingViewController: UIViewController {
    
    @IBOutlet var resultLabel: UILabel!
    
    var savedData = NSUserDefaults.standardUserDefaults()
    var displayString: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        displayString = savedData.objectForKey("displayTextRoleWorkingTORoleChanging") as! String
        resultLabel.text = displayString
        
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
        let targetView = self.storyboard!.instantiateViewControllerWithIdentifier( "roleprecheck" )
        self.presentViewController( targetView, animated: true, completion: nil)
    
    }
}
