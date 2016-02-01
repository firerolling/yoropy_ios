//
//  SelectTimeViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/22.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit

class AddDateViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDelegate {
    
    
    
    
    @IBOutlet weak var dateTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        self.dateTableView.reloadData()
        
        let nib:UINib = UINib(nibName: "DateCell", bundle: nil)
        self.dateTableView.registerNib(nib, forCellReuseIdentifier: "DateCell")
        
        if NSUserDefaults.standardUserDefaults().objectForKey("date") != nil {
            dateList =
                NSUserDefaults.standardUserDefaults().objectForKey("date") as! [String]
        }
        
        
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateList.count
        
    }
    
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("DateCell") as? DateCell
        cell!.dateLabel.text = dateList[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            dateList.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(dateList, forKey: "date")
            dateTableView.reloadData()
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        self.dateTableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func popover(sender: AnyObject) {
        self.performSegueWithIdentifier("showView", sender: self)
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showView"
        {
            var vc = segue.destinationViewController as! UIViewController
            vc.preferredContentSize = CGSize(width: self.view.frame.width, height: 300)
            
            var controller = vc.popoverPresentationController
            
            if controller != nil
            {
                controller?.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) ->UIModalPresentationStyle {
        return .None
    }
    
    
    
    
    
}






