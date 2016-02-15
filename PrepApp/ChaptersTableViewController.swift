//
//  ChaptersTableViewController.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 23/07/15.
//  Copyright (c) 2016 PrepApp. All rights reserved.
//

import UIKit
import RealmSwift

class ChaptersTableViewController: UITableViewController {
    
    var subject: Subject?
    var chaptersRealm: Results<Chapter>?
    var chapters: [Chapter] = []
    var color = UIColor.clearColor()
    let realm = FactoryRealm.getRealm()

    //app methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view!.backgroundColor = Colors.greyBackground
        self.title = "Chapitres"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logout", name: "failed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update", name: "update", object: nil)
        self.loadChapters()
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Segoe UI", size: 20)!]
        self.navigationController!.navigationBar.tintColor = Colors.greenLogo

        switch (self.subject!.name) {
        case "physique" :
            self.color = Colors.phy
        case "chimie" :
            self.color = Colors.che
        case "biologie" :
            self.color = Colors.bio
        default :
            self.color = UIColor.clearColor()
        }
        self.navigationController?.navigationBar.barTintColor = self.color
        self.navigationController?.navigationBar.translucent = true

    }
    
    override func viewDidAppear(animated: Bool) {
        //sync
        FactoryHistory.getHistory().sync(){ _ in return }
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        // Return the number of rows in the section.
        return self.chapters.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chapter", forIndexPath: indexPath) 

        // Configure the cell...
        cell.textLabel?.font = UIFont(name: "Segoe UI", size: 14)
        cell.textLabel?.text = "\(self.chapters[indexPath.row].number) : \(self.chapters[indexPath.row].name)"
        return cell
    }
    
    //methods
    func loadChapters() {
        self.chaptersRealm = self.realm.objects(Chapter).filter("subject == %@", subject!)
        
        for chapter in self.chaptersRealm! {
            if !self.isChapterEmpty(chapter){
                self.chapters.append(chapter)
            }
        }
        self.chapters.sortInPlace { $0.number < $1.number }
    }
    
    func isChapterEmpty(chapter: Chapter) -> Bool {
        
        var tempQuestions = [Question]()
        //fetching training questions
        var questionsRealm = realm.objects(Question).filter("chapter = %@ AND type = 0", chapter)
        for question in questionsRealm {
            tempQuestions.append(question)
        }
        
        //fetching solo questions already DONE
        questionsRealm = realm.objects(Question).filter("chapter = %@ AND type = 1", chapter)
        for question in questionsRealm {
            if FactoryHistory.getHistory().isQuestionDone(question.id){
                tempQuestions.append(question)
            }
        }
        
        //fetching duo questions already DONE
        questionsRealm = realm.objects(Question).filter("chapter = %@ AND type = 2", chapter)
        for question in questionsRealm {
            if FactoryHistory.getHistory().isQuestionDone(question.id){
                tempQuestions.append(question)
            }
            
        }
        if tempQuestions.count == 0 {
            return true
        } else {
            return false
        }
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        let questionVC = segue.destinationViewController as! QuestionViewController
        // Pass the selected object to the new view controller.
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedChapter = chapters[indexPath.row]
            questionVC.currentChapter = selectedChapter
            questionVC.currentSubject = subject
        }

    }
    




}