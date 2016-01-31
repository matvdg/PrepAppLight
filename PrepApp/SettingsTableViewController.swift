//
//  ProfileTableViewController.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 30/09/15.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import UIKit
import LocalAuthentication

class SettingsTableViewController: UITableViewController {
    
    var settings = ["Modifier votre pseudo", "Modifier votre mot de passe", "Bruitages", "Touch ID", "Notifications"]
    
    var nickname = UITextField()
    var password = UITextField()
    var confirmationPassword = UITextField()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        self.view!.backgroundColor = Colors.greyBackground
        self.tableView!.backgroundColor = Colors.greyBackground
        self.tableView!.tintColor = Colors.greenLogo
        super.viewDidLoad()
        self.loadSettings()
        //sync
        FactoryHistory.getHistory().sync { (success) -> (Void) in
            if !success {
                print("no connexion in syncHistory")
            }
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update", name: "update", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logout", name: "failed", object: nil)
        if self.revealViewController() != nil {
            self.menuButton.target = self.revealViewController()
            self.menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Segoe UI", size: 20)!]
        self.navigationController!.navigationBar.tintColor = Colors.greenLogo
        self.title = "Réglages"
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("setting", forIndexPath: indexPath) as! UITableViewCellSetting
        cell.textLabel?.textColor = UIColor.blackColor()
        cell.textLabel!.text = self.settings[indexPath.row]
        cell.backgroundColor = Colors.greyBackground
        cell.switcher.backgroundColor = Colors.greyBackground
        cell.textLabel!.adjustsFontSizeToFitWidth = false
        cell.textLabel!.font = UIFont(name: "Segoe UI", size: 16)
        cell.tintColor = Colors.green
        cell.switcher.layer.zPosition = 10
        cell.switcher.tintColor = Colors.green
        
        switch self.settings[indexPath.row] {
            case "Modifier votre pseudo":
                cell.switcher.hidden = true
                cell.tintColor = Colors.green
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.imageView!.image = UIImage(named: "identity")
            case "Modifier votre mot de passe":
                cell.switcher.hidden = true
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.tintColor = Colors.green
                cell.imageView!.image = UIImage(named: "lock")
            case "Touch ID":
                cell.switcher.setOn(UserPreferences.touchId, animated: true)
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.imageView!.image = UIImage(named: "touchID")
                cell.switcher.addTarget(self, action: "touchIDSwitch", forControlEvents: UIControlEvents.TouchUpInside)
            case "Bruitages":
                cell.switcher.setOn(UserPreferences.sounds, animated: true)
                cell.imageView!.image = UIImage(named: "sounds")
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.switcher.addTarget(self, action: "soundSwitch", forControlEvents: UIControlEvents.TouchUpInside)
            case "Notifications":
                cell.switcher.setOn(UserPreferences.notifications, animated: true)
                cell.imageView!.image = UIImage(named: "notifications")
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.switcher.addTarget(self, action: "notificationsSwitch", forControlEvents: UIControlEvents.TouchUpInside)

            default:
                print("error")
        }
        return cell
    }
    
    //UITableViewDelegate Methods
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.settings[indexPath.row] == "Modifier votre pseudo" {
            self.changeNickname()
        } else if self.settings[indexPath.row] == "Modifier votre mot de passe" {
            self.changePassword()
        }
    }

    
    //Methods
    func logout() {
        print("logging out")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func update() {
        // create alert controller
        let myAlert = UIAlertController(title: "Une mise à jour des questions est disponible", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        myAlert.view.tintColor = Colors.green
        // add "later" button
        myAlert.addAction(UIAlertAction(title: "Plus tard", style: UIAlertActionStyle.Cancel, handler: nil))
        // add "update" button
        myAlert.addAction(UIAlertAction(title: "Mettre à jour maintenant", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        // show the alert
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    private func loadSettings() {
        //loading settings preferences
        UserPreferences.loadUserPreferences()
        
        //Touch ID
        let authenticationObject = LAContext()
        let authenticationError = NSErrorPointer()
        authenticationObject.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: authenticationError)
        if authenticationError != nil {
            self.settings.removeAtIndex(self.settings.indexOf("Touch ID")!)
        }
        
        //Nickname
        if !FactorySync.getConfigManager().loadNicknamePreference() {
            self.settings.removeAtIndex(self.settings.indexOf("Modifier votre pseudo")!)
        }
    }
    
    //Nickname Methods
    func addNickname(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = User.currentUser!.nickname
        self.nickname = textField
    }
    
    func changeNickname() {
        // create alert controller
        let myAlert = UIAlertController(title: "Modifier votre pseudo", message: "Taper votre nouveau pseudonyme ou votre prénom/nom, si vous le souhaitez.", preferredStyle: UIAlertControllerStyle.Alert)
        myAlert.view.tintColor = Colors.green
        // add buttons
        myAlert.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Cancel, handler: nil))
        myAlert.addAction(UIAlertAction(title: "Modifier", style: UIAlertActionStyle.Destructive, handler: self.sendNickname))
        //add prompt
        myAlert.addTextFieldWithConfigurationHandler(self.addNickname)
        // show the alert
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    func sendNickname(alert: UIAlertAction!) {
        if self.nickname.text != "" {
            SwiftSpinner.setTitleFont(UIFont(name: "Segoe UI", size: 22.0))
            SwiftSpinner.show("")
            User.currentUser!.changeNickname(self.nickname.text!, callback: { (message) -> Void in
                // create alert controller
                let myAlert = UIAlertController(title: message!, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                myAlert.view.tintColor = Colors.green
                // add "OK" button
                myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                // show the alert
                SwiftSpinner.hide()
                self.presentViewController(myAlert, animated: true, completion: nil)
            })
            
        } else {
            // create alert controller
            let myAlert = UIAlertController(title: "Oups !", message: "Le pseudo ne peut être vide.", preferredStyle: UIAlertControllerStyle.Alert)
            myAlert.view.tintColor = Colors.green
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            // show the alert
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
        
    
    }
    
    //Password Methods
    func addPassword(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = "Nouveau mot de passe"
        textField.secureTextEntry = true
        textField.textColor = Colors.green
        self.password = textField
    }
    
    func addConfirmationPassword(textField: UITextField!){
        // add the text field and make the result global
        textField.placeholder = "Confirmation"
        textField.secureTextEntry = true
        textField.textColor = Colors.green
        self.confirmationPassword = textField
    }
    
    func changePassword() {
        // create alert controller
        let myAlert = UIAlertController(title: "Modifier votre mot de passe", message: "Minimum huit caractères dont une majuscule et deux chiffres.", preferredStyle: UIAlertControllerStyle.Alert)
        myAlert.view.tintColor = Colors.green
        // add buttons
        myAlert.addAction(UIAlertAction(title: "Annuler", style: UIAlertActionStyle.Cancel, handler: nil))
        myAlert.addAction(UIAlertAction(title: "Modifier", style: .Destructive, handler: self.sendPassword))
        //add prompts
        myAlert.addTextFieldWithConfigurationHandler(self.addPassword)
        myAlert.addTextFieldWithConfigurationHandler(self.addConfirmationPassword)
        // show the alert
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    private func sendPassword(alert: UIAlertAction!) {
        if (self.password.text!.hasGoodLength() && self.password.text!.hasTwoNumber() && self.password.text!.hasUppercase()){
            if self.password.text == self.confirmationPassword.text {
                SwiftSpinner.setTitleFont(UIFont(name: "Segoe UI", size: 22.0))
                SwiftSpinner.show("")
                User.currentUser?.changePassword(self.password.text!.sha1(), callback: { (message) -> Void in
                    // create alert controller
                    let myAlert = UIAlertController(title: message!, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                    myAlert.view.tintColor = Colors.green
                    // add "OK" button
                    myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    // show the alert
                    SwiftSpinner.hide()
                    self.presentViewController(myAlert, animated: true, completion: nil)
                })
                
            } else {
                // create alert controller
                let myAlert = UIAlertController(title: "Oups !", message: "Le nouveau mot de passe et la confirmation ne correspondent pas.", preferredStyle: UIAlertControllerStyle.Alert)
                myAlert.view.tintColor = Colors.green
                // add "OK" button
                myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                // show the alert
                self.presentViewController(myAlert, animated: true, completion: nil)
            }
        } else {
            // create alert controller
            let myAlert = UIAlertController(title: "Le mot de passe est trop faible !", message: "Minimum huit caractères dont une majuscule et deux chiffres.", preferredStyle: UIAlertControllerStyle.Alert)
            myAlert.view.tintColor = Colors.green
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            // show the alert
            self.presentViewController(myAlert, animated: true, completion: nil)
        }
    }
    
    //Touch ID Method
    func touchIDSwitch() {
        let cell = self.tableView!.cellForRowAtIndexPath(NSIndexPath(forRow: self.settings.indexOf("Touch ID")!, inSection: 0)) as! UITableViewCellSetting
        if cell.switcher!.on {
            UserPreferences.touchId = true
            UserPreferences.saveUserPreferences()
            // create alert controller
            let myAlert = UIAlertController(title: "Touch ID activé", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            myAlert.view.tintColor = Colors.green
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            // show the alert
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        } else {
            UserPreferences.touchId = false
            UserPreferences.saveUserPreferences()
            // create alert controller
            let myAlert = UIAlertController(title: "Touch ID désactivé", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            myAlert.view.tintColor = Colors.green
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            // show the alert
            self.presentViewController(myAlert, animated: true, completion: nil)
            
        }
    }
    
    //Sounds Method
    func soundSwitch() {
        let cell = self.tableView!.cellForRowAtIndexPath(NSIndexPath(forRow: self.settings.indexOf("Bruitages")!, inSection: 0)) as! UITableViewCellSetting
        if cell.switcher!.on {
            UserPreferences.sounds = true
            UserPreferences.saveUserPreferences()
            Sound.playTrack("notif")
        } else {
            UserPreferences.sounds = false
            UserPreferences.saveUserPreferences()
        }
    }
    
    //Notifications Method
    func notificationsSwitch() {
        let cell = self.tableView!.cellForRowAtIndexPath(NSIndexPath(forRow: self.settings.indexOf("Notifications")!, inSection: 0)) as! UITableViewCellSetting
        if cell.switcher!.on {
            UIApplication.sharedApplication().registerForRemoteNotifications()
            UserPreferences.notifications = true
            UserPreferences.saveUserPreferences()
        } else {
            UIApplication.sharedApplication().unregisterForRemoteNotifications()
            UserPreferences.sounds = false
            UserPreferences.saveUserPreferences()
        }
    }

    

}
