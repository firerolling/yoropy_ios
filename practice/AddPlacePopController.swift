
//
//  SecondViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/28.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit
import SafariServices
import Parse


var titleList = [String]()
var detailList = [String]()

class AddPlacePopViewController: UIViewController, UITextFieldDelegate {
    
    let titleField = UITextField()
    let detailField = UITextField()
    private var urlString:String = "http://tabelog.com/"
    private var urlGurunavi:String = "http://www.gnavi.co.jp/"
    @IBOutlet weak var globalStrings01: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatWhiteColor()
        self.view.alpha = 0.5
        
        let label = UILabel()
        label.text = "ADD PLACE"
        label.textAlignment = .Center
        label.textColor = UIColor.flatBlueColorDark()
        label.font = UIFont(name: "Arcon", size: 26)
        label.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height/12)
        label.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(label)
        
        
        titleField.backgroundColor = UIColor.whiteColor()
        titleField.layer.borderColor = UIColor.flatBlueColor().CGColor
        titleField.placeholder = "  PLACE"
        titleField.frame = CGRectMake(15, label.frame.height+10 , self.view.frame.width-50, 50)
        titleField.layer.borderWidth = 1
        titleField.layer.cornerRadius = 10
        titleField.textAlignment = .Left
        titleField.font = UIFont(name: "Arcon", size: 24)
        self.view.addSubview(titleField)
        
        
        
        // create the detail label
        
        
        detailField.backgroundColor = UIColor.whiteColor()
        detailField.layer.borderColor = UIColor.flatBlueColor().CGColor
        detailField.frame = CGRectMake(15, titleField.frame.origin.y+60 , self.view.frame.width-50, 50)
        detailField.layer.borderWidth = 1
        detailField.placeholder = "  URL"
        detailField.layer.cornerRadius = 10
        detailField.textAlignment = .Left
        detailField.font = UIFont(name: "Arcon", size: 24)
        self.view.addSubview(detailField)
        
        
        titleField.delegate = self
        detailField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: UIButton) {
        
        titleList.append(titleField.text!)
        titleField.text = ""
        NSUserDefaults.standardUserDefaults().setObject(titleList, forKey: "title")
        
        detailList.append(detailField.text!)
        detailField.text = ""
        NSUserDefaults.standardUserDefaults().setObject(detailList, forKey: "detail")
       
    
    }
      
    
    @IBAction func openGoogle(sender: UIButton) {
        let svc = SFSafariViewController(URL: NSURL(string: self.urlString)!)
        self.presentViewController(svc, animated: true, completion: nil)
        
        
    }
    
    @IBAction func openGuruNavi(sender: UIButton) {
        let svc = SFSafariViewController(URL: NSURL(string: self.urlGurunavi)!)
        
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        titleField.resignFirstResponder()
        detailField.resignFirstResponder()
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
