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
    
   
    
 //   @IBOutlet weak var titleField: UITextField!
   
    @IBOutlet weak var imageView: UIImageView!

    

    
    //追加のメンバ変数
    var eventTitle :String = ""
    var eventPhoto :UIImage! = nil
    var eventPlace :String = ""
    var eventDate  :String = ""
    
    //保存用メンバ変数
    
    var saveEventTitle :String!
    var saveEventPhoto :UIImage? = nil
    var uploadEventPhoto :PFFile!
    var saveEventPlace :String!
    var saveEventDate :String!
    
    
    
    
    
    var cells: [LiquidFloatingCell] = []
    var floatingActionButton: LiquidFloatingActionButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        
//        titleField.delegate = self
    
        
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
        
        let floatingFrame2 = CGRect(x: 0, y: 80, width: 56, height: 56)
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
    
    func numberOfCells(liquidFloatingActionButton: LiquidFloatingActionButton) -> Int {
        return cells.count
    }
    
    func cellForIndex(index: Int) -> LiquidFloatingCell {
        return cells[index]
    }
    
    func liquidFloatingActionButton(liquidFloatingActionButton: LiquidFloatingActionButton, didSelectItemAtIndex index: Int) {
        print("did Tapped! \(index)")
        switch index{
        case 1:
            let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let next:UIViewController = storyboard.instantiateViewControllerWithIdentifier("Time") as UIViewController
            
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
        
//        self.saveEventTitle = self.titleField.text
        
        let savingObjects = PFObject(className: "Event")
        
       // savingObjects["title"] = self.saveEventTitle
        savingObjects["photo"] = self.uploadEventPhoto
        savingObjects["user"] = PFUser.currentUser()!.username
     //   savingObjects["date"] = self.saveEventDate
        
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

    
    
        

    


