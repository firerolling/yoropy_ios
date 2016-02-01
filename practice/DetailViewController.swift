//
//  DetailViewController.swift
//  practice
//
//  Created by 株式会社ConU on 2016/01/27.
//  Copyright © 2016年 株式会社ConU. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    
    var eventObjectId: String!
    var eventDetailData: AnyObject!
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventObjectId = self.eventDetailData.valueForKey("objectId") as? String
        
        let dispImgFile: PFFile = (self.eventDetailData.valueForKey("photo") as? PFFile)!
        
        dispImgFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                let image = UIImage(data: imageData!)
                self.imageLabel.image = image
                self.imageLabel.contentMode = UIViewContentMode.Redraw
            }
            
        }
        
        self.titleLabel.text = self.eventDetailData.valueForKey("title") as? String
        self.placeLabel.text = self.eventDetailData.valueForKey("place") as? String
        self.dataLabel.text = self.eventDetailData.valueForKey("date") as? String
        self.userLabel.text = self.eventDetailData.valueForKey("user") as? String

        // Do any additional setup after loading the view.
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

}
