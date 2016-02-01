//
//  NewEventViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/22.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit
import LiquidFloatingActionButton
import Parse

class NewEventViewController: UIViewController, LiquidFloatingActionButtonDataSource, LiquidFloatingActionButtonDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var sectionTitleArray : NSMutableArray = NSMutableArray()
    var sectionContentDict : NSMutableDictionary = NSMutableDictionary()
    var arrayForBool : NSMutableArray = NSMutableArray()
   
   
    @IBOutlet weak var tableView: UITableView!
    
 //   @IBOutlet weak var titleField: UITextField!
   
    @IBOutlet weak var imageView: UIImageView!
    
    var placeName :String! //ポップアップのplacetitleをこっちのコントローラに受けるための変数定義
    //var dateArray :[String]!
    //@IBOutlet weak var placetitle: UILabel!
    
    @IBOutlet weak var test: UILabel!
    
    
    //追加のメンバ変数
    var eventTitle :String = ""
    var eventPhoto :UIImage! = nil
    var eventPlace :[String] = []
    var eventDate  :[String] = []
    
    //保存用メンバ変数
    
    var saveEventTitle :String!
    var saveEventPhoto :UIImage? = nil
    var uploadEventPhoto :PFFile!
    var saveEventPlace :[String] = []
    var saveEventDate :[String] = []
    
    
    

    
    
    
    var cells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
//        print(dateArray)
//         test.text = dateArray[0]
//        titleField.delegate = self
        
//        for object in dateArray {
//            let label = object
//            print("ラベル:\(label)")
//        }
        
        self.view.bringSubviewToFront(imageView)
        
        closeButton.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
        
        let createButton: (CGRect, LiquidFloatingActionButtonAnimateStyle) -> LiquidFloatingActionButton = { (frame, style) in
            let floatingActionButton = LiquidFloatingActionButton(frame: frame)
            floatingActionButton.animateStyle = style
            floatingActionButton.dataSource = self
            floatingActionButton.delegate = self
            return floatingActionButton
            
        
            
            
            
        }
        
        
        
        //フローティングの追加ボタンの配置
        let cellFactory: (String) -> LiquidFloatingCell = { (iconName) in
            return LiquidFloatingCell(icon: UIImage(named: iconName)!)
        }
        cells.append(cellFactory("date"))
        cells.append(cellFactory("place"))
        cells.append(cellFactory("camera"))
        cells.append(cellFactory("write"))
        cells.append(cellFactory("bell"))
        
       //フローティングの配置
        
        let floatingFrame2 = CGRect(x: 0, y: 230, width: 50, height: 50)
        let topLeftButton = createButton(floatingFrame2, .Right)
        
                self.view.addSubview(topLeftButton)
        
        
    }
    
    //終了ボタン
    
    
    
    
    
    
    @IBAction func closeAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //バーを消す
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: true)
    }
    
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(arrayForBool .objectAtIndex(section).boolValue == true)
        {
            let tps = sectionTitleArray.objectAtIndex(section) as! String
            let count1 = (sectionContentDict.valueForKey(tps)) as! NSArray
            return count1.count
        }
        return 0;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ABC"
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(arrayForBool .objectAtIndex(indexPath.section).boolValue == true){
            return 60
        }
        
        return 2;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 55))
        headerView.backgroundColor = UIColor.flatPurpleColorDark()
        headerView.tag = section
        
        
        let headerString = UILabel(frame: CGRect(x: 5, y: 10, width: tableView.frame.size.width-10, height: 40)) as UILabel
        headerString.text = sectionTitleArray.objectAtIndex(section) as? String
        headerString.font = UIFont(name: "Arcon", size: 30)
        headerString.textAlignment = .Center
        headerString.textColor = UIColor.whiteColor()
        headerView .addSubview(headerString)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:"sectionHeaderTapped:")
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }
    
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        print("Tapping working")
        print(recognizer.view?.tag)
        
        let indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if (indexPath.row == 0) {
            
            var collapsed = arrayForBool .objectAtIndex(indexPath.section).boolValue
            collapsed       = !collapsed;
            
            arrayForBool .replaceObjectAtIndex(indexPath.section, withObject: collapsed)
            //reload specific section animated
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = NSIndexSet(indexesInRange: range)
            self.tableView .reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifier = "Cell"
        let cell: UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        
        let manyCells : Bool = arrayForBool .objectAtIndex(indexPath.section).boolValue
        
        if (!manyCells) {
            //  cell.textLabel.text = @"click to enlarge";
        }
        else{
            let content = sectionContentDict .valueForKey(sectionTitleArray.objectAtIndex(indexPath.section) as! String) as! NSArray
            cell.textLabel?.text = content .objectAtIndex(indexPath.row) as? String
            cell.backgroundColor = UIColor .flatPurpleColor()
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.layer.frame.size = CGSize(width: tableView.frame.width, height: 60)
        }
        
        return cell
    }
    

  
    
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        print("did Tapped! \(index)")
        switch index{
        case 0:
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let next:UIViewController = storyboard.instantiateViewControllerWithIdentifier("Date") as UIViewController
            
            next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            self.presentViewController(next, animated: true, completion: nil)
        

        case 1:
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let next:UIViewController = storyboard.instantiateViewControllerWithIdentifier("Place") as UIViewController
            
            next.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            
            self.presentViewController(next, animated: true, completion: nil)
        case 2:
            
            //カメラのクロップとライブラリの追加
            var croppingEnabled: Bool = false
            var libraryEnabled: Bool = true
            
            //カメラの追加
            let cameraViewController = ALCameraViewController(croppingEnabled: croppingEnabled, allowsLibraryAccess: libraryEnabled) { (image) -> Void in
                self.imageView.image = image
                self.dismissViewControllerAnimated(true, completion: nil)
                self.view.sendSubviewToBack(self.imageView)
            }
            
            presentViewController(cameraViewController, animated: true, completion: nil)
            

        default:
            break
        }
    }
    
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        titleField.resignFirstResponder()
//        return true }

    @IBAction func addButton(sender: UIButton) {
        
        self.saveEventPhoto = self.imageView.image
        let imageData :NSData = UIImagePNGRepresentation(self.saveEventPhoto!)!
        self.uploadEventPhoto = PFFile(name: "event.png", data: imageData)!
        self.saveEventTitle = self.titleField.text
        self.saveEventDate = dateList
        self.saveEventPlace = titleList
        
        let savingObjects = PFObject(className: "Event")
        
       savingObjects["title"] = self.saveEventTitle
        savingObjects["photo"] = self.uploadEventPhoto
        savingObjects["user"] = PFUser.currentUser()!.username
        //savingObjects["date"] = self.saveEventDate
        
        savingObjects.saveInBackgroundWithBlock{ (success: Bool, error: NSError?) -> Void in
            
            if success {
                let alert = SCLAlertView()
                alert.showSuccess("Event added!", subTitle: "Your new event has been added to timeline!")
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                let alert = SCLAlertView()
                alert.showError("Oops!", subTitle: "something went wrong!")
            }
            
        }
        
    }
    
    }


    
    
        

    


