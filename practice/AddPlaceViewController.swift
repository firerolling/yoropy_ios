//
//  AddPlaceViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/22.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit
import Parse

class AddPlaceViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDelegate,UITableViewDataSource {
    
    
    
    var savePlaceTitle :String!
    @IBOutlet weak var placeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        if NSUserDefaults.standardUserDefaults().objectForKey("title") != nil {
            titleList =
                NSUserDefaults.standardUserDefaults().objectForKey("title") as! [String]
        }
        let nib:UINib = UINib(nibName: "PlaceCell", bundle: nil)
        self.placeTableView.registerNib(nib, forCellReuseIdentifier: "PlaceCell")
        
    
        
        
    }
    
       
    @IBAction func alertBtn(sender: UIButton) {
        let alertController = UIAlertController(title: "Hello!", message: "This is Alert sample.", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count

    }
    
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell! {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell") as? PlaceCell
        cell!.titleLabel.text = titleList[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            titleList.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(titleList, forKey: "title")
            placeTableView.reloadData()
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        placeTableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func popover(sender: AnyObject) {
        self.performSegueWithIdentifier("showView", sender: self)
    }
    
    @IBAction func backToList(sender: AnyObject) {
        self.performSegueWithIdentifier("placetodetail", sender: self)
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
        else if segue.identifier == "placetodetail"
        {
            let newEventViewController = segue.destinationViewController as! NewEventViewController
            newEventViewController.placeName = titleList[0]
//            let savingObjects = PFObject(className: "Event")
//            
//            savingObjects["placeTitle"] = titleList[0]
//            
//            savingObjects.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
//                
//                if success {
//                    let alert = SCLAlertView()
//                    alert.showSuccess("Event added!", subTitle: "Your new event has been added to timeline!")
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                }else{
//                    let alert = SCLAlertView()
//                    alert.showError("Oops!", subTitle: "something went wrong!")
//                }
//                
//            }

        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) ->UIModalPresentationStyle {
        return .None
    }

    
}
