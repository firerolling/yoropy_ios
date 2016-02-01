//
//  AddDatePopController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/02/01.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit


func format(date : NSDate, style : String) -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
    dateFormatter.dateFormat = style
    return  dateFormatter.stringFromDate(date)
}

var dateList = [String]()

class AddDatePopViewController: UIViewController, UITextFieldDelegate {
    
    
    let label1 = UILabel()
   
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func changeDate(sender: UIDatePicker) {
        label1.text = format(datePicker.date, style: "yyyy年MM月dd日　HH時mm分")

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatWhiteColor()
        self.view.alpha = 0.5
        
        let label = UILabel()
        label.text = "ADD DATE & TIME"
        label.textAlignment = .Center
        label.textColor = UIColor.flatBlueColorDark()
        label.font = UIFont(name: "Arcon", size: 26)
        label.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/12)
        label.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(label)
        
        
        
        datePicker.backgroundColor = UIColor.flatWatermelonColor()
        
        

        // create the detail label
        
        
        
        
       
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: UIButton) {
        
        dateList.append(label1.text!)
        NSUserDefaults.standardUserDefaults().setObject(dateList, forKey: "date")
    
        
        
        let parentVC = presentingViewController as! AddDateViewController
        parentVC.dateTableView.reloadData()
        
        
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
              
        return true
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

