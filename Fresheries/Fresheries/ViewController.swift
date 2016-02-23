//
//  ViewController.swift
//  Fresheries
//
//  Created by Manav Ramesh on 2/20/16.
//  Copyright © 2016 Manav Ramesh. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import ALCameraViewController
import AFNetworking
import JGProgressHUD

var archivedFoods: [Food] = []

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    var foods: [Food] = []
    
    // load this from local data
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
       
        // the foods will be loaded from the local table; this is just for testing
        
        tableView.dataSource = self
        tableView.delegate = self

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        let cropEnabled: Bool = false
        let cameraViewController = ALCameraViewController(croppingEnabled: cropEnabled) { image in
            // Do something with your image here.
            // If cropping is enabled this image will be the cropped version
            // process image
            // dismiss the camera view controller
            
            if image != nil {
                let HUD: JGProgressHUD = JGProgressHUD(style: JGProgressHUDStyle.Dark)
                HUD.textLabel.text = "Processing..."
                HUD.showInView(self.view!)
                let imageData: NSData = UIImageJPEGRepresentation(image!, 0.5)!
                let manager: AFHTTPSessionManager = AFHTTPSessionManager()
                manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
                manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
                manager.responseSerializer = AFHTTPResponseSerializer()
                manager.POST("http://9903fa43.ngrok.io/upload", parameters: nil, constructingBodyWithBlock: {(formData: AFMultipartFormData) -> Void in
                    //let currentTimeStamp = NSDate().timeIntervalSince1970
                    formData.appendPartWithFileData(imageData, name: "image", fileName: "image.jpg", mimeType: "image/jpeg")
                    }, success: {(operation: NSURLSessionDataTask, responseObject: AnyObject?) -> Void in
                        do {
                            let data = responseObject as! NSData
                            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                            print("json \(json)")
                            if let array = json["items"] as? [[String: String]] {
                                for foodDict in array {
                                    let food = Food()
                                    food.name = foodDict["productname"]! as String
                                    let shelfString = foodDict["expiry date"]! as String
                                    food.shelfLife = Int(shelfString)
                                    food.buyDate = NSDate()
                                    self.foods.append(food)
                                }
                            }
                            
                            print("success")
                            HUD.dismiss()
                            self.tableView.reloadData()
                        } catch {
                            HUD.dismiss()
                            print("error")
                        }
                    }, failure: {(operation: NSURLSessionDataTask?, error: NSError
                        
                        ) -> Void in
                        print("error details \(error.description)")
                        HUD.dismiss()
                        print("failure")
                })
            }
            self.dismissViewControllerAnimated(true, completion: nil)
            // refresh the stuff
        }
        
        self.presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // if this is 0, add a little view
        return foods.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodTableViewCell") as! FoodTableViewCell
        cell.food = foods[indexPath.row]
        
        //configure right buttons
        let ateButton = MGSwipeButton(title: "Ate",backgroundColor: UIColor.lightGrayColor(), callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            let indexPath = tableView.indexPathForCell(sender)!
            // let food = self.foods[indexPath.row]

            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            return true
        })

        let expiredButton = MGSwipeButton(title: "Expired", backgroundColor: UIColor.redColor(), callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            let indexPath = tableView.indexPathForCell(sender)!
            // let food = self.foods[indexPath.row]

            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            return true
        })
        
        cell.rightButtons = [ateButton, expiredButton]
        cell.rightSwipeSettings.transition = MGSwipeTransition.Rotate3D
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

