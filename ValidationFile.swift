//
//  ValidationFile.swift
//  4Breeders
//
//  Created by Rp on 19/06/20.
//  Copyright © 2020 Dharmesh Sonani. All rights reserved.
//

import Foundation

// MARK: Hide KeyBord

pod 'IQKeyboardManagerSwift'

IQKeyboardManager.shared.enable = true

// MARK: Validation

var controller = UIAlertController()

controller = UIAlertController.init(title: "Message", message: "Add to Favourites", preferredStyle: .alert)

let actionOk = UIAlertAction.init(title: "Ok", style: .default, handler: { (action) in
    
    self.dismiss(animated: true, completion: nil)
    
})
controller.addAction(actionOk)

self.present(controller, animated: true, completion: nil)


// MARK: Json Calling

func getSliderimg(){
    
    let strParam = "lang=\(appDelegate.strLanguage)"
    
    let strUrl = "http://4breeders.com/Api/Slider"
    
    WebParserWS.fetchDataWithURL(url: strUrl as NSString, type: .TYPE_POST, ServiceName: "getSliderimg", bodyObject: strParam as AnyObject, delegate: self, isShowProgress: true)
}

func didFinishWithSuccess(ServiceName: String, Response: AnyObject) {
    
    if ServiceName == "getCategoryTop"
    {
        let result = "\(Response.value(forKey: "status") as! Int)"
        
        if result == "1"{
            
            DispatchQueue.main.async {
                
                self.arrCategory = Response.value(forKey: "data") as! NSArray
                print(self.arrCategory)
                self.tblView.reloadData()
            }
            
            
        }else{
            
        }
    }
}



// Mark: Tabbar Controller

 func setupTabbarcontroller()
 {
     
     let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
     
     let tabBarcontroller = storyBoard.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
     
//     adsView.frame = CGRect.init(x: (UIScreen.main.bounds.size.width)/5 * 4, y: 0, width: (UIScreen.main.bounds.size.width)/5, height: tabBarcontroller.tabBar.frame.size.height)
//     adsView.backgroundColor = UIColor.init(red: 238/255, green: 171/255, blue: 167/255, alpha: 1)
//     tabBarcontroller.tabBar.addSubview(adsView)
     
     tabBarcontroller.delegate = self
     
     for navigation in tabBarcontroller.viewControllers!
     {
         let nav = navigation as! UINavigationController
         nav.navigationBar.barTintColor = UIColor.init(red: 239/255, green: 101/255, blue: 90/255, alpha: 1)
         nav.navigationBar.isHidden = false
         nav.navigationBar.tintColor = UIColor.white
         
         nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
         
         let controller = nav.viewControllers[0]
         
         var strImg : String = ""
         
         var strTitle : String = ""
         
         if controller.isKind(of: HomeViewController.self)
         {
             strImg = "Home_Icon"
             strTitle = "Home
         }
         else if controller.isKind(of: AllBidsTblViewController.self)
         {
            strImg = "bid_icon"
            strTitle = "Auctions"
         }
         else if controller.isKind(of: AdsViewController.self){
             
            strImg = "add_bid_icon"
            strTitle = "Add Ads"
         }
         else if controller.isKind(of: DirectoryViewController.self){
             
             strImg = "worldwide"
             strTitle = "Breeders"
         }
         else {
             strImg = "More_icon"
             strTitle = "More"
         }
         
         var image = UIImage.init(named: strImg)
         image = image?.withRenderingMode(.alwaysTemplate)
         
         navigation.tabBarItem.image = image
         
         navigation.tabBarItem.title = strTitle
         
        // navigation.tabBarItem.imageInsets = UIEdgeInsets.init(top: 6, left: 0, bottom: -6, right: 0)
     }
     
     tabBarcontroller.selectedIndex = 4
    // tabBarcontroller.tabBar.unselectedItemTintColor = UIColor.init(red: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 1.0)
//     tabBarcontroller.tabBar.unselectedItemTintColor = UIColor.init(red: 243/255, green: 152/255, blue: 143/255, alpha: 1)
     tabBarcontroller.tabBar.unselectedItemTintColor = UIColor.white
     tabBarcontroller.tabBar.tintColor = UIColor.black
//     tabBarcontroller.tabBar.barTintColor = UIColor.white
     tabBarcontroller.tabBar.barTintColor = UIColor.init(red: 236.0/255.0, green: 103.0/255.0, blue: 90.0/255.0, alpha: 1.0)
     
     
     
     self.window?.rootViewController = tabBarcontroller
     self.window?.makeKeyAndVisible()
 }


