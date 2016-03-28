//
//  SoloViewController.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 14/05/15.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import UIKit

class SoloViewController: UIViewController {
	
    static var challengeEnded = false
    var buttonBio: UIButton?
    var buttonPhy: UIButton?
    var buttonChe: UIButton?
    var buttonBioPhy: UIButton?
    var buttonBioChe: UIButton?
    var buttonChePhy: UIButton?
    var buttonAll: UIButton?
    
    let realm = FactoryRealm.getRealm()
    
    enum choices:Int {
        case none = 0, biology, physics, chemistry, bioPhy, bioChe, chePhy, all
    }
    var choice = choices.none
    
	@IBOutlet var menuButton: UIBarButtonItem!
    @IBOutlet weak var trigram: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonChallenge: UIButton!
    
    @IBAction func runChallenge(sender: AnyObject) {
        if self.choice == .none {
            // create alert controller
            let myAlert = UIAlertController(title: "Veuillez toucher le trigramme pour choisir au moins une matière", message: "Vous pouvez également choisir des combinaisons de deux ou trois matières", preferredStyle: UIAlertControllerStyle.Alert)
            myAlert.view.tintColor = Colors.green
            // add "OK" button
            myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            // show the alert
            self.presentViewController(myAlert, animated: true, completion: nil)

        } else {
            if self.checkQuestions() {
                // create alert controller
                let myAlert = UIAlertController(title: "Lancer le défi ?", message: "Vous devez disposer de \(FactorySync.getConfigManager().loadDuration()) minutes. Un défi lancé ne peut être mis en pause !", preferredStyle: UIAlertControllerStyle.Alert)
                myAlert.view.tintColor = Colors.green
                // add buttons
                myAlert.addAction(UIAlertAction(title: "Oui", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
                    self.performSegueWithIdentifier("showSolo", sender: self)
                }))
                myAlert.addAction(UIAlertAction(title: "Non", style: UIAlertActionStyle.Cancel, handler: nil))
                // show the alert
                self.presentViewController(myAlert, animated: true, completion: nil)
            } else {
                // create alert controller
                let myAlert = UIAlertController(title: "Ce défi n'est plus disponible pour le moment", message: "Revenez plus tard pour de nouvelles questions ou allez dans le mode Entraînement pour refaire les questions déjà vues.", preferredStyle: UIAlertControllerStyle.Alert)
                myAlert.view.tintColor = Colors.green
                // add "OK" button
                myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                // show the alert
                self.presentViewController(myAlert, animated: true, completion: nil)
 
            }
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let value = UIInterfaceOrientation.Portrait.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        //sync
        FactoryHistory.getHistory().sync(){ _ in return }
        if SoloViewController.challengeEnded {
            SoloViewController.challengeEnded = false
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SoloViewController.refresh), name: "portrait", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SoloViewController.refresh), name: "landscape", object: nil)

        self.view.backgroundColor = Colors.greyBackground
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Segoe UI", size: 20)!]
        self.navigationController!.navigationBar.tintColor = Colors.greenLogo

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SoloViewController.logout), name: "failed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(SoloViewController.update), name: "update", object: nil)
		if self.revealViewController() != nil {
			self.menuButton.target = self.revealViewController()
			self.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
			self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        } else {
            self.menuButton.image = UIImage(named: "home")
            self.menuButton.target = self
            self.menuButton.action = #selector(SoloViewController.dismiss)
        }
        self.trigram.image = UIImage(named: "default")
        self.buttonChallenge.layer.cornerRadius = 6
        self.renderButtons()
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

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
    
    func refresh() {
        print("refreshing")
        self.buttonChePhy?.removeFromSuperview()
        self.buttonPhy?.removeFromSuperview()
        self.buttonChe?.removeFromSuperview()
        self.buttonBioPhy?.removeFromSuperview()
        self.buttonBioChe?.removeFromSuperview()
        self.buttonBio?.removeFromSuperview()
        self.buttonAll?.removeFromSuperview()
        self.renderButtons()
    }
    
    func renderButtons() {
        let size: CGFloat = 185
        self.trigram.layer.zPosition = 1
        self.label.layer.zPosition = 2
        self.buttonChallenge.layer.zPosition = 3
        //biology
        self.buttonBio = UIButton(frame: CGRectMake((self.view.bounds.width / 2) - (size/2) - (size/3), (self.view.bounds.height / 2) - (size/2) - (size/3), size, size))
        self.buttonBio!.layer.cornerRadius = (size/2)
        self.buttonBio!.alpha = 0.9
        //self.buttonBio?.backgroundColor = UIColor.greenColor()
        self.view.addSubview(self.buttonBio!)
        self.buttonBio!.addTarget(self, action: #selector(SoloViewController.selectBio), forControlEvents: UIControlEvents.TouchUpInside)
        
        //physics
        self.buttonPhy = UIButton(frame: CGRectMake((self.view.bounds.width / 2) - (size/2) + (size/3), (self.view.bounds.height / 2) - (size/2) - (size/3), size, size))
        self.buttonPhy!.layer.cornerRadius = (size/2)
        self.buttonPhy!.alpha = 0.9
        //self.buttonPhy?.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.buttonPhy!)
        self.buttonPhy!.addTarget(self, action: #selector(SoloViewController.selectPhy), forControlEvents: UIControlEvents.TouchUpInside)
        
        //chemistry
        self.buttonChe = UIButton(frame: CGRectMake((self.view.bounds.width / 2) - (size/2), (self.view.bounds.height / 2) - (size/2)  + (size/3), size, size))
        self.buttonChe!.layer.cornerRadius = (size/2)
        self.buttonChe!.alpha = 0.9
        //self.buttonChe?.backgroundColor = UIColor.blueColor()
        self.view.addSubview(self.buttonChe!)
        self.buttonChe!.addTarget(self, action: #selector(SoloViewController.selectChe), forControlEvents: UIControlEvents.TouchUpInside)
        
        //bio/phy
        self.buttonBioPhy = UIButton(frame: CGRectMake((self.view.bounds.width / 2) - (size/6), (self.view.bounds.height / 2) - (size/2) - (size/4), size/3 , size/3 + 40))
        self.buttonBioPhy!.layer.cornerRadius = (size/6)
        self.buttonBioPhy!.alpha = 0.9
        //self.buttonBioPhy?.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(self.buttonBioPhy!)
        self.buttonBioPhy!.addTarget(self, action: #selector(SoloViewController.selectBioPhy), forControlEvents: UIControlEvents.TouchUpInside)
        
        //bio/che
        self.buttonBioChe = UIButton(frame: CGRectMake((self.view.bounds.width / 2) - (size/6) - (size/2),  (self.view.bounds.height / 2) - (size/5), size/3 + 40, size/3))
        self.buttonBioChe!.layer.cornerRadius = (size/6)
        self.buttonBioChe!.alpha = 0.9
        //self.buttonBioChe?.backgroundColor = UIColor.brownColor()
        self.view.addSubview(self.buttonBioChe!)
        self.buttonBioChe!.addTarget(self, action: #selector(SoloViewController.selectBioChe), forControlEvents: UIControlEvents.TouchUpInside)
        
        //che/phy
        self.buttonChePhy = UIButton(frame: CGRectMake((self.view.bounds.width / 2) - (size/6) + 60, (self.view.bounds.height / 2) - (size/5), size/3 + 40, size/3))
        self.buttonChePhy!.layer.cornerRadius = (size/6)
        self.buttonChePhy!.alpha = 0.9
        //self.buttonChePhy?.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(self.buttonChePhy!)
        self.buttonChePhy!.addTarget(self, action: #selector(SoloViewController.selectChePhy), forControlEvents: UIControlEvents.TouchUpInside)
        
        //all
        self.buttonAll = UIButton(frame: CGRectMake((self.view.bounds.width / 2) - (size/4), (self.view.bounds.height / 2) - (size/3), size/2, size/2))
        self.buttonAll!.layer.cornerRadius = (size/4)
        self.buttonAll!.alpha = 0.9
        //self.buttonAll?.backgroundColor = UIColor.darkGrayColor()
        self.view.addSubview(self.buttonAll!)
        self.buttonAll!.addTarget(self, action: #selector(SoloViewController.selectAll as (SoloViewController) -> () -> ()), forControlEvents: UIControlEvents.TouchUpInside)



        
    }
    
    func selectBio(){
        self.label.text = "Défi Biologie"
        self.choice = .biology
        print("Biologie")
        self.trigram.image = UIImage(named: "tribio")
    }
    
    func selectPhy(){
        self.label.text = "Défi Physique"
        self.choice = .physics
        print("Physique")
        self.trigram.image = UIImage(named: "triphy")
    }
    
    func selectChe(){
        self.label.text = "Défi Chimie"
        self.choice = .chemistry
        print("Chimie")
        self.trigram.image = UIImage(named: "trichi")
    }
    
    func selectBioChe(){
        self.label.text = "Défi Biologie/Chimie"
        self.choice = .bioChe
        print("Biologie/Chimie")
        self.trigram.image = UIImage(named: "tribiochi")
    }
    
    func selectChePhy(){
        self.label.text = "Défi Chimie/Physique"
        self.choice = .chePhy
        print("Chimie/Physique")
        self.trigram.image = UIImage(named: "trichiphy")
    }
    
    func selectBioPhy(){
        self.label.text = "Défi Biologie/Physique"
        self.choice = .bioPhy
        print("Biologie/Physique")
        self.trigram.image = UIImage(named: "tribiophy")
    }
    
    func selectAll(){
        self.label.text = "Défi Biologie/Chimie/Physique"
        self.choice = .all
        print("Biologie/Chimie/Physique")
        self.trigram.image = UIImage(named: "triall")
    }
    
    func checkQuestions() -> Bool {
        
        var result = false
        
        var tempQuestions = [Question]()
        //fetching solo questions NEVER DONE
        let questionsRealm = realm.objects(Question).filter("type = 1")
        for question in questionsRealm {
            if FactoryHistory.getHistory().isQuestionNew(question.id){
                tempQuestions.append(question)
            }
        }
        
        //now applying the trigram choice choosen by user 1 biology, 2 physics, 3 chemistry, 4 bioPhy, 5 bioChe, 6 chePhy, 7 all
        var counter = 0
        switch self.choice.rawValue {
            
        case 1: //biology
            
            for question in tempQuestions {
                if question.chapter!.subject!.id == 1 && counter < 12 {
                    counter += 1
                }
            }
            if counter == 12 {
                result = true
            }
        case 2: //physics
            for question in tempQuestions {
                if question.chapter!.subject!.id == 2 && counter < 6 {
                    counter += 1
                }
            }
            if counter == 6 {
                result = true
            }
            
        case 3: //chemistry
            for question in tempQuestions {
                if question.chapter!.subject!.id == 3 && counter < 6 {
                    counter += 1
                }
            }
            if counter == 6 {
                result = true
            }
            
        case 4: //bioPhy
            for question in tempQuestions {
                if question.chapter!.subject!.id == 1 && counter < 8 {
                    counter += 1
                }
            }
            if counter == 8 {
                for question in tempQuestions {
                    if question.chapter!.subject!.id == 2 && counter < 11 {
                        counter += 1
                    }
                }
                if counter == 11 {
                    result = true
                }

            }
            
        case 5: //bioChe
            for question in tempQuestions {
                if question.chapter!.subject!.id == 1 && counter < 8 {
                    counter += 1
                }
            }
            if counter == 8 {
                for question in tempQuestions {
                    if question.chapter!.subject!.id == 3 && counter < 11 {
                        counter += 1
                    }
                }
                if counter == 11 {
                    result = true
                }

            }
            
        case 6: //chePhy
            for question in tempQuestions {
                if question.chapter!.subject!.id == 2 && counter < 4 {
                    counter += 1
                }
            }
            if counter == 4 {
                for question in tempQuestions {
                    if question.chapter!.subject!.id == 3 && counter < 6 {
                        counter += 1
                    }
                }
                if counter == 6 {
                    result = true
                }

            }
            
        case 7: //all
            for question in tempQuestions {
                if question.chapter!.subject!.id == 1 && counter < 6 {
                    counter += 1
                }
            }
            if counter == 6 {
                for question in tempQuestions {
                    if question.chapter!.subject!.id == 2 && counter < 8 {
                        counter += 1
                    }
                }
                if counter == 8 {
                    for question in tempQuestions {
                        if question.chapter!.subject!.id == 3 && counter < 9 {
                            counter += 1
                        }
                    }
                    if counter == 9 {
                        result = true
                    }
                }
                

            }
            
        default:
            print("default")
        }
        
        return result
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        let QSVC = segue.destinationViewController as! QuestionSoloViewController
        // Pass the selected object to the new view controller.
        QSVC.choice = self.choice.rawValue
    }


}
