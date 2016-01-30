
import UIKit
import Charts

class HomeViewController: UIViewController, ChartViewDelegate, UIViewControllerPreviewingDelegate {
    
    //properties
    enum subject: Int {
        case biology = 1, physics, chemistry
    }
    var bioPercent: Double = 0
    var phyPercent: Double = 0
    var chePercent: Double = 0
    var bioNumber: Int = 0
    var phyNumber: Int = 0
    var cheNumber: Int = 0
    var bioNumberToDo: Int = 0
    var phyNumberToDo: Int = 0
    var cheNumberToDo: Int = 0
    var bioPerf: [Double] = []
    var phyPerf: [Double] = []
    var chePerf: [Double] = []
    var questionsAnswered: [Double] = []
    var weeksBeforeExam : [String] = []
    var statsPanelDisplayed: Bool = false
    var currentStatsPanelDisplayed: Int = 0
    var type: subject = .biology
    let offsetAngle: CGFloat = 270
    var legendLeftAxis = UILabel()
    var legendRightAxis = UILabel()
    var legendXAxis = UILabel()
    var noDataLabel = UILabel()
    var notification = UILabel()
    
    //@IBOutlets properties
    @IBOutlet weak var menuButton:UIBarButtonItem!
    @IBOutlet weak var chePieChart: PieChartView!
    @IBOutlet weak var phyPieChart: PieChartView!
    @IBOutlet weak var bioPieChart: PieChartView!
    @IBOutlet weak var levelButton: UIButton!
    @IBOutlet weak var perfChart: CombinedChartView!
    @IBOutlet weak var bioButton: UIButton!
    @IBOutlet weak var cheButton: UIButton!
    @IBOutlet weak var phyButton: UIButton!
    @IBOutlet weak var bioLogo: UIImageView!
    @IBOutlet weak var cheLogo: UIImageView!
    @IBOutlet weak var phyLogo: UIImageView!
    @IBOutlet weak var stats: UILabel!
    @IBOutlet weak var legend: UILabel!
    @IBOutlet weak var target: UIImageView!
    
    
    //@IBAction methods
    @IBAction func showBioStats(sender: AnyObject) {
        Sound.playTrack("next")
        if self.statsPanelDisplayed {
            if self.currentStatsPanelDisplayed == 1 {
                self.statsPanelDisplayed = false
                self.stats.hidden = true
                self.cheButton.layer.cornerRadius = 6
                self.bioButton.layer.cornerRadius = 6
            } else {
                let shape = CAShapeLayer()
                shape.bounds = self.cheButton.frame
                shape.position = self.cheButton.center
                shape.path = UIBezierPath(roundedRect: self.cheButton.bounds, byRoundingCorners: UIRectCorner.TopRight, cornerRadii: CGSize(width: 6, height: 6)).CGPath
                self.cheButton.layer.cornerRadius = 0
                self.cheButton.layer.mask = shape
                self.currentStatsPanelDisplayed = 1
                self.stats.text = "Progression : \(Int(self.bioPercent))%   -   \(self.bioNumber) \(self.singularOrPlural(1, type: 0))    Niveau suivant : \(self.bioNumberToDo) \(self.singularOrPlural(1, type: 1))"
                self.stats.backgroundColor = Colors.bio
                self.stats.hidden = false
            }
        } else {
            let shape = CAShapeLayer()
            shape.bounds = self.cheButton.frame
            shape.position = self.cheButton.center
            shape.path = UIBezierPath(roundedRect: self.cheButton.bounds, byRoundingCorners: UIRectCorner.TopRight, cornerRadii: CGSize(width: 6, height: 6)).CGPath
            self.cheButton.layer.cornerRadius = 0
            self.cheButton.layer.mask = shape
            self.statsPanelDisplayed = true
            self.currentStatsPanelDisplayed = 1
            self.stats.text = "Progression : \(Int(self.bioPercent))%   -   \(self.bioNumber) \(self.singularOrPlural(1, type: 0))    Niveau suivant : \(self.bioNumberToDo) \(self.singularOrPlural(1, type: 1))"
            self.stats.backgroundColor = Colors.bio
            self.stats.hidden = false
        }
    }
    
    @IBAction func showPhyStats(sender: AnyObject) {
        Sound.playTrack("next")
        if self.statsPanelDisplayed {
            if self.currentStatsPanelDisplayed == 2 {
                self.statsPanelDisplayed = false
                self.stats.hidden = true
                self.bioButton.layer.cornerRadius = 6
                self.cheButton.layer.cornerRadius = 6
            } else {
                let shapeBio = CAShapeLayer()
                shapeBio.bounds = self.bioButton.frame
                shapeBio.position = self.bioButton.center
                shapeBio.path = UIBezierPath(roundedRect: self.bioButton.bounds, byRoundingCorners: UIRectCorner.TopLeft, cornerRadii: CGSize(width: 6, height: 6)).CGPath
                self.bioButton.layer.cornerRadius = 0
                self.bioButton.layer.mask = shapeBio
                let shapeChe = CAShapeLayer()
                shapeChe.bounds = self.cheButton.frame
                shapeChe.position = self.cheButton.center
                shapeChe.path = UIBezierPath(roundedRect: self.cheButton.bounds, byRoundingCorners: UIRectCorner.TopRight, cornerRadii: CGSize(width: 6, height: 6)).CGPath
                self.cheButton.layer.cornerRadius = 0
                self.cheButton.layer.mask = shapeChe
                self.currentStatsPanelDisplayed = 2
                self.stats.text = "Progression : \(Int(self.phyPercent))%   -   \(self.phyNumber) \(self.singularOrPlural(2, type: 0))    Niveau suivant : \(self.phyNumberToDo) \(self.singularOrPlural(2, type: 1))"
                self.stats.backgroundColor = Colors.phy
                self.stats.hidden = false
            }
        } else {
            let shapeBio = CAShapeLayer()
            shapeBio.bounds = self.bioButton.frame
            shapeBio.position = self.bioButton.center
            shapeBio.path = UIBezierPath(roundedRect: self.bioButton.bounds, byRoundingCorners: UIRectCorner.TopLeft, cornerRadii: CGSize(width: 6, height: 6)).CGPath
            self.bioButton.layer.cornerRadius = 0
            self.bioButton.layer.mask = shapeBio
            let shapeChe = CAShapeLayer()
            shapeChe.bounds = self.cheButton.frame
            shapeChe.position = self.cheButton.center
            shapeChe.path = UIBezierPath(roundedRect: self.cheButton.bounds, byRoundingCorners: UIRectCorner.TopRight, cornerRadii: CGSize(width: 6, height: 6)).CGPath
            self.cheButton.layer.cornerRadius = 0
            self.cheButton.layer.mask = shapeChe

            self.statsPanelDisplayed = true
            self.currentStatsPanelDisplayed = 2
            self.stats.text = "Progression : \(Int(self.phyPercent))%   -   \(self.phyNumber) \(self.singularOrPlural(2, type: 0))    Niveau suivant : \(self.phyNumberToDo) \(self.singularOrPlural(2, type: 1))"
            self.stats.backgroundColor = Colors.phy
            self.stats.hidden = false
        }
    }
    
    @IBAction func showCheStats(sender: AnyObject) {
        Sound.playTrack("next")
        if self.statsPanelDisplayed {
            if self.currentStatsPanelDisplayed == 3 {
                self.statsPanelDisplayed = false
                self.stats.hidden = true
                self.bioButton.layer.cornerRadius = 6
                self.cheButton.layer.cornerRadius = 6
            } else {
                let shape = CAShapeLayer()
                shape.bounds = self.bioButton.frame
                shape.position = self.bioButton.center
                shape.path = UIBezierPath(roundedRect: self.bioButton.bounds, byRoundingCorners: UIRectCorner.TopLeft, cornerRadii: CGSize(width: 6, height: 6)).CGPath
                self.bioButton.layer.cornerRadius = 0
                self.bioButton.layer.mask = shape
                self.currentStatsPanelDisplayed = 3
                self.stats.text = "Progression : \(Int(self.chePercent))%   -   \(self.cheNumber) \(self.singularOrPlural(3, type: 0))    Niveau suivant : \(self.cheNumberToDo) \(self.singularOrPlural(3, type: 1))"
                self.stats.backgroundColor = Colors.che
                self.stats.hidden = false
            }
        } else {
            let shape = CAShapeLayer()
            shape.bounds = self.bioButton.frame
            shape.position = self.bioButton.center
            shape.path = UIBezierPath(roundedRect: self.bioButton.bounds, byRoundingCorners: UIRectCorner.TopLeft, cornerRadii: CGSize(width: 6, height: 6)).CGPath
            self.bioButton.layer.cornerRadius = 0
            self.bioButton.layer.mask = shape
            self.statsPanelDisplayed = true
            self.currentStatsPanelDisplayed = 3
            self.stats.text = "Progression : \(Int(self.chePercent))%   -   \(self.cheNumber) \(self.singularOrPlural(3, type: 0))    Niveau suivant : \(self.cheNumberToDo) \(self.singularOrPlural(3, type: 1))"
            self.stats.backgroundColor = Colors.che
            self.stats.hidden = false
        }
    }

    @IBAction func showStats(sender: AnyObject) {
        self.hidePieCharts(true)
        self.performSegueWithIdentifier("showStats", sender: self)
    }
    
    
    //app methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if( traitCollection.forceTouchCapability == .Available){
            registerForPreviewingWithDelegate(self, sourceView: self.view)
        }
        //notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logout", name: "failed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update", name: "update", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goTraining", name: "goTraining", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goSolo", name: "goSolo", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goDuo", name: "goDuo", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "goContest", name: "goContest", object: nil)
        
        if self.revealViewController() != nil {
            self.menuButton.target = self.revealViewController()
            self.menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //sync
        FactoryHistory.getHistory().sync()
        //retrieving data
        self.renderLevel()
        self.retrieveData()
        //designing border radius buttons
        self.bioButton.layer.cornerRadius = 6
        self.cheButton.layer.cornerRadius = 6
        self.stats.layer.cornerRadius = 6
        self.stats.layer.masksToBounds = true
        //z positions
        self.phyButton.layer.zPosition = 3
        self.phyLogo.layer.zPosition = 4
        self.bioButton.layer.zPosition = 2
        self.bioLogo.layer.zPosition = 4
        self.cheButton.layer.zPosition = 2
        self.cheLogo.layer.zPosition = 4
        self.stats.layer.zPosition = 1
        self.perfChart.layer.zPosition = 7
        self.legend.layer.zPosition = 0
        self.noDataLabel.layer.zPosition = 8
        //other customization
        self.bioPieChart.noDataText = ""
        self.bioPieChart.noDataTextDescription = ""
        self.phyPieChart.noDataText = ""
        self.phyPieChart.noDataTextDescription = ""
        self.chePieChart.noDataText = ""
        self.chePieChart.noDataTextDescription = ""
        self.view!.backgroundColor = Colors.greyBackground
        self.legend.text = ""
        self.stats.hidden = true
        self.view.backgroundColor = Colors.greyBackground
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Segoe UI", size: 20)!]
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.renderPieCharts()
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: date)
        let currentDay = components.day
        if  FactorySync.getConfigManager().loadCurrentDay() != currentDay {
            FactorySync.getConfigManager().saveCurrentDay(currentDay)
            self.displayNotification(self.getWelcomeMessage(), refreshGraph: false)
        }
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5)
        notification.alertBody = "Préparez-vous à réussir!"
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func logout() {
        ///called when touchID failed, authenticated = false
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

    
    //methods
    private func retrieveData() {
        
        var (percent,answers,todo) = FactoryHistory.getScoring().getScore(1)
        self.bioPercent = Double(percent)
        self.bioNumber = answers
        self.bioNumberToDo = todo
        (percent,answers,todo) = FactoryHistory.getScoring().getScore(2)
        self.phyPercent = Double(percent)
        self.phyNumber = answers
        self.phyNumberToDo = todo
        (percent,answers,todo) = FactoryHistory.getScoring().getScore(3)
        self.chePercent = Double(percent)
        self.cheNumber = answers
        self.cheNumberToDo = todo
        
        self.bioPerf = FactoryHistory.getScoring().getPerf(1)
        self.phyPerf = FactoryHistory.getScoring().getPerf(2)
        self.chePerf = FactoryHistory.getScoring().getPerf(3)
        self.questionsAnswered = FactoryHistory.getScoring().getQuestionsAnswered()
        self.weeksBeforeExam = FactoryHistory.getScoring().getWeeksBeforeExam()
        self.checkNumberOfData()
    }
    
    func checkNumberOfData() {
        var max = self.weeksBeforeExam.count
        if self.bioPerf.count < max {
            max = self.bioPerf.count
        }
        if self.phyPerf.count < max {
            max = self.phyPerf.count
        }
        if self.chePerf.count < max {
            max = self.chePerf.count
        }
        while self.weeksBeforeExam.count != max {
            self.weeksBeforeExam.removeLast()
        }
        while self.questionsAnswered.count != max {
            self.questionsAnswered.removeLast()
        }
        while self.bioPerf.count != max {
            self.bioPerf.removeLast()
        }
        while self.phyPerf.count != max {
            self.phyPerf.removeLast()
        }
        while self.chePerf.count != max {
            self.chePerf.removeLast()
        }
    }
    
    func getWelcomeMessage() -> String {
        if UserPreferences.welcome {
            UserPreferences.welcome = false
            UserPreferences.saveUserPreferences()
            return "Bienvenue \(User.currentUser!.firstName) \(User.currentUser!.lastName) !"
        } else {
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.Hour, fromDate: date)
            let hour = components.hour
            if hour > 18 {
                return "Bonsoir \(User.currentUser!.firstName) !"
            } else {
                return "Bonjour \(User.currentUser!.firstName) !"
            }
        }
    }
    
    func singularOrPlural(subject: Int, type: Int) -> String {
        
        var number = 0
        
        switch subject {
        case 1 : //biology
            switch type {
            case 0 : //succeeded
                    number = bioNumber
            case 1 : //todo
                number = bioNumberToDo
            default :
                print("error")
            }
        
        case 2 : //physics
            switch type {
            case 0 : //succeeded
                number = phyNumber
            case 1 : //todo
                number = phyNumberToDo
            default :
                print("error")
            }
        case 3 : //chemistry
            switch type {
            case 0 : //succeeded
                number = cheNumber
            case 1 : //todo
                number = cheNumberToDo
            default :
                print("error")
            }
        default:
            print("error")
        }
        
        switch type {
        case 0 : //succeeded
            if number == 0 || number == 1 {
                return "question réussie"
            } else {
                return "questions réussies"
            }
        case 1 : //todo
            if number == 0 || number == 1 {
                return "question"
            } else {
                return "questions"
            }
        default :
            return "error"
        }
    }
    
    func renderBiologyPieChart(){
        
        //pie settings
        self.bioPieChart.delegate = self
        self.bioPieChart.backgroundColor = UIColor.clearColor()
        self.bioPieChart.usePercentValuesEnabled = false
        self.bioPieChart.holeTransparent = true
        self.bioPieChart.holeColor = UIColor.clearColor()
        self.bioPieChart.holeRadiusPercent = 0
        self.bioPieChart.transparentCircleRadiusPercent = 0
        self.bioPieChart.drawHoleEnabled = false
        self.bioPieChart.drawSliceTextEnabled = false
        self.bioPieChart.drawMarkers = false
        self.bioPieChart.legend.setCustom(colors: [UIColor.clearColor()], labels: [""])
        //data
        self.type = .biology
        self.bioPieChart.data = self.getPieChartData(self.type.rawValue)
        //centerText
        //self.bioPieChart.centerTextColor = UIColor.blueColor()
        self.bioPieChart.centerText = ""
        //description
        self.bioPieChart.descriptionFont = UIFont(name: "Segoe UI", size: 17)!
        self.bioPieChart.descriptionText = ""
        //self.bioPieChart.descriptionTextColor = UIColor.redColor()
        //rotation
        self.bioPieChart.rotationAngle = self.offsetAngle
        self.bioPieChart.rotationEnabled = false

    }
    
    func renderPhysicsPieChart(){
        //pie settings
        self.phyPieChart.delegate = self
        self.phyPieChart.backgroundColor = UIColor.clearColor()
        self.phyPieChart.usePercentValuesEnabled = true
        self.phyPieChart.holeTransparent = true
        self.phyPieChart.holeColor = UIColor.clearColor()
        self.phyPieChart.holeRadiusPercent = 0.76
        self.phyPieChart.transparentCircleRadiusPercent = 0
        self.phyPieChart.drawHoleEnabled = true
        self.phyPieChart.drawSliceTextEnabled = true
        self.phyPieChart.drawMarkers = false
        self.phyPieChart.legend.setCustom(colors: [UIColor.clearColor()], labels: [""])
        //data
        self.type = .physics
        self.phyPieChart.data = self.getPieChartData(self.type.rawValue)
        //centerText
        self.phyPieChart.centerText = ""
        //self.phyPieChart.centerTextFont = UIFont(name: "Segoe UI", size: 17)!
        //description
        self.phyPieChart.descriptionFont = UIFont(name: "Segoe UI", size: 17)!
        self.phyPieChart.descriptionText = ""
        //rotation
        self.phyPieChart.rotationAngle = self.offsetAngle
        self.phyPieChart.rotationEnabled = false

    }
    
    func renderChemistryPieChart(){
        //pie settings
        self.chePieChart.delegate = self
        self.chePieChart.backgroundColor = UIColor.clearColor()
        self.chePieChart.usePercentValuesEnabled = true
        self.chePieChart.holeTransparent = true
        self.chePieChart.holeColor = UIColor.clearColor()
        self.chePieChart.holeRadiusPercent = 0.805
        self.chePieChart.transparentCircleRadiusPercent = 0
        self.chePieChart.drawHoleEnabled = true
        self.chePieChart.drawSliceTextEnabled = false
        self.chePieChart.drawMarkers = false
        self.chePieChart.legend.setCustom(colors: [UIColor.clearColor()], labels: [""])
        //data
        self.type = .chemistry
        self.chePieChart.data = self.getPieChartData(self.type.rawValue)
        //centerText
        self.chePieChart.centerText = ""
        //self.chePieChart.centerTextFont = UIFont(name: "Segoe UI", size: 17)!
        //description
        self.chePieChart.descriptionFont = UIFont(name: "Segoe UI", size: 17)!
        self.chePieChart.descriptionText = ""
        //rotation
        self.chePieChart.rotationAngle = self.offsetAngle
        self.chePieChart.rotationEnabled = false

    }
    
    func renderLevel(){
        self.levelButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 70)
        self.levelButton.backgroundColor = Colors.greenLogo
        self.levelButton.layer.zPosition = 100
        self.levelButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.levelButton.layer.borderWidth = 6
        self.levelButton.setTitle(User.currentUser!.level.levelPrepApp(), forState: .Normal)
        self.levelButton.titleLabel!.adjustsFontSizeToFitWidth = true
        self.levelButton.titleLabel!.numberOfLines = 1
        self.levelButton.titleLabel!.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        self.levelButton.layer.cornerRadius = self.levelButton.frame.width / 2
    }
    
    func animateLevel() {
        // Create CAAnimation
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.fromValue = 0
        animation.toValue = NSNumber(float: Float(M_PI)/2)
        animation.duration = 0.5
        animation.repeatCount = 0
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        Sound.playTrack("levelup")
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        self.levelButton.layer.addAnimation(animation, forKey: nil)
        UIView.animateWithDuration(0.5) { () -> Void in
            self.levelButton.setTitle(User.currentUser!.level.levelPrepApp(), forState: .Normal)
        }
    }
    
    func renderPieCharts() {
        self.hidePieCharts(true)
        self.renderChemistryPieChart()
        self.renderPhysicsPieChart()
        self.renderBiologyPieChart()
        self.animatePieCharts()
    }
    
    func getPieChartData(subject: Int) -> ChartData {
        
        
        var yVals: [ChartDataEntry] = []
        switch subject {
        case 1 :
            yVals.append(BarChartDataEntry(value: self.bioPercent, xIndex: 1))
            yVals.append(BarChartDataEntry(value: 100-self.bioPercent, xIndex: 2))
        case 2 :
            yVals.append(BarChartDataEntry(value: self.phyPercent, xIndex: 1))
            yVals.append(BarChartDataEntry(value: 100-self.phyPercent, xIndex: 2))
        case 3 :
            yVals.append(BarChartDataEntry(value: self.chePercent, xIndex: 1))
            yVals.append(BarChartDataEntry(value: 100-self.chePercent, xIndex: 2))
        default :
            yVals.append(BarChartDataEntry(value: 50, xIndex: 1))
        }
        let dataSet : PieChartDataSet = PieChartDataSet(yVals: yVals)
        dataSet.sliceSpace = 0.0
        var colors: [UIColor] = [Colors.bio,Colors.phy,Colors.che]
        
        switch subject {
        case 1 :
            colors = [Colors.bio,UIColor.clearColor()]
        case 2 :
            colors = [Colors.phy,UIColor.clearColor()]
        case 3 :
            colors = [Colors.che,UIColor.clearColor()]
        default :
            colors = [Colors.greyBackground]
        }
        dataSet.colors = colors
        dataSet.valueTextColor = UIColor.clearColor()
        let data: PieChartData = PieChartData(xVals: ["",""], dataSet: dataSet)
        return data
    }
    
    func animatePieCharts() {
        self.hidePieCharts(false)
        let animation = ChartEasingOption.Linear
        let timeInterval = NSTimeInterval(1.0)
        self.bioPieChart.animate(yAxisDuration: timeInterval, easingOption: animation)
        self.phyPieChart.animate(yAxisDuration: timeInterval, easingOption: animation)
        self.chePieChart.animate(yAxisDuration: timeInterval, easingOption: animation)
        //after animation, one level up if necessary
        while (self.bioPercent == 100 && self.phyPercent == 100 && self.chePercent == 100) {
            //everything at 100%, one level up!
            var win = ["Le travail est la clef du succès !","Félicitations ! Vous avez gagné un niveau !","Le succès naît de la persévérance.","L'obstination est le chemin de la réussite !","Un travail constant vient à bout de tout.","Le mérite résulte de la persévérance.","La persévérance est la mère des succès.","La persévérance fait surmonter bien des obstacles."]
            win.shuffle()
            self.displayNotification(win[0], refreshGraph: true)
            User.currentUser!.level = User.currentUser!.level + 1
            User.currentUser!.saveUser()
            User.currentUser!.updateLevel(User.currentUser!.level)
            //retrieving new data
            self.retrieveData()
        }
    }
    
    func hidePieCharts(bool: Bool) {
        self.chePieChart.hidden = bool
    }
    
    func displayNotification(text: String, refreshGraph: Bool) {
        self.notification = UILabel(frame: CGRectMake(0, 0, self.view!.frame.width, 50))
        self.notification.text = text
        self.notification.backgroundColor = Colors.green
        self.notification.textColor = UIColor.whiteColor()
        self.notification.textAlignment = NSTextAlignment.Center
        self.notification.font = UIFont(name: "Segoe UI", size: 16)
        self.notification.layer.zPosition = 100
        self.notification.alpha = 0
        self.view!.addSubview(self.notification)
        UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.notification.frame.origin.y = self.notification.frame.origin.y + 60
            self.notification.alpha = 1
            }) { (success) -> Void in
                UIView.animateWithDuration(2, delay: 2, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    self.notification.frame.origin.y = self.notification.frame.origin.y - 60
                    self.notification.alpha = 0
                    }) { (success) -> Void in
                        self.notification.removeFromSuperview()
                        if refreshGraph {
                            self.renderPieCharts()
                            self.animateLevel()
                        }
                }
        }
    }
    
    //quickActions methods
    func goTraining() {
        self.hidePieCharts(true)
        self.performSegueWithIdentifier("goTraining", sender: self)
    }
    
    func goSolo() {
        self.hidePieCharts(true)
        self.performSegueWithIdentifier("goSolo", sender: self)
    }
    
    func goDuo() {
        self.hidePieCharts(true)
        self.performSegueWithIdentifier("goDuo", sender: self)
    }
    
    func goContest() {
        self.hidePieCharts(true)
        self.performSegueWithIdentifier("goContest", sender: self)
    }

    
    //peek&pop
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let statsVC = storyboard?.instantiateViewControllerWithIdentifier("StatsVC") as? StatsViewController
        statsVC!.preferredContentSize = CGSize(width: 0.0, height: 400)
        previewingContext.sourceRect = self.view!.frame
        return statsVC
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        self.showViewController(viewControllerToCommit, sender: self)
    }


}
