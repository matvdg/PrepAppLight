//
//  HelpViewController.swift
//  PrepApp
//
//  Created by Mathieu Vandeginste on 31/10/2015.
//  Copyright © 2015 PrepApp. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {
    
    
    var selectedHelp = 0
    var helpPics = ["home", "training",  "solo","newsfeed", "stats", "marked", "leaderboard", "feedback", "settings", "credits", "cgu"]
    var helpTopics = ["Accueil","Entraînement","Défi","Actualités","Statistiques","Marquages", "Classement", "Feed-back", "Réglages","Mentions légales", "CGU"]
    var helpTexts = [
        //0- Aide accueil
        "Consultez d’un coup d’oeil votre diagramme de niveau et ciblez vos révisions. Obtenez le détail de votre progression pour chaque matière en touchant les boutons de la légende.",
        
        //1- Aide Entraînement
        "Orientez vos révisions en choisissant la matière et le chapitre que vous souhaitez.\n\nSi la solution de la question est incomprise, marquez-la en appuyant sur le drapeau afin de faire part à vos professeurs de vos difficultés. Vous pouvez y ajouter un commentaire destiné à vos professeurs. Toutes ces questions sont accessibles dans la section \"Marquages\" afin de les retravailler par la suite.\n\nAppuyez sur \"Question\" pour afficher la barre des filtres et retrouvez les nouvelles questions, celles réussies, marquées ou échouées. Filtrez également les questions provenant du modes défi si vous voulez les refaire. \n\nUne question faite vous rapporte 1 AwardPoint pour l'assiduité et 5 AwardPoints si elle a été réussie pour la première fois. Si une question provient d'un défi, vous gagnerez un second AwardPoint d'assiduité en y répondant de nouveau !",
        
        //2- Aide Défi
        "Vous disposez de \(FactorySync.getConfigManager().loadDuration()) minutes ? Grâce au trigramme choisissez la matière, ou la combinaison de matières afin de créer le défi qui vous convient.\n\nLes questions du défi n’ont jamais été vues auparavant et basculent dans le mode Entraînement une fois le défi terminé. Une question faite vous rapporte 1 AwardPoint pour l'assiduité et 5 AwardPoints si elle a été réussie pour la première fois. Chaque point gagné au dessus de 10/20 vous fait gagner un bonus de 2 AwardPoints.\n\nUne fois le défi terminé, vous accédez à votre score et à votre correction. Si la solution de la question est incomprise, marquez-la en appuyant sur le drapeau afin de faire part à vos professeurs de vos difficultés.",
        
        //3- Aide newsfeed
        "Retrouver les actualités de votre établissement ! Communications de votre établissement (changement de planning par exemple) ou de vos professeurs (devoirs à faire), tout y est ! Vous pouvez glisser vers le bas dans l'accueil d'Actualités pour actualiser la page.",
        
        //4- Aide statistiques
        "Consultez ici vos statistiques Prep'App Kiné ! Votre assiduité représente le nombre de questions répondues qu'elles soient justes ou fausses (chaque question rapporte un AwardPoint) tandis que votre niveau ne tient compte que de vos questions réussies.\n\nLes questions basculées dans le mode Entraînement (provenant du mode Défi) vous rapportent un deuxième point d’assiduité si vous y répondez à nouveau.\n\nLes AwardPoints représentent donc vos performances et votre assiduité. Dans les défis vous pourrez gagner des AwardPoints Bonus.\n\nVous pouvez également consulter l’échéance fixée par votre établissement (date et nombre de semaines restantes).\n\nPour personnaliser la couleur de votre badge, touchez simplement sur vos initiales puis touchez à nouveau sur la couleur de votre choix.",
        
        //5- Aide marquages
        "Retrouvez ici toutes les questions que vous avez marquées dans l'app. Appuyez sur i pour afficher la question et sa correction ou touchez pour envoyer une question à votre professeur. Sur une ligne, glissez vers la gauche pour enlever le marquage d'une question.",
        
        //6- Aide classement
        "Situez-vous dans votre établissement avec notre classement Prep'App grâce aux AwardPoints. Glissez vers le bas pour actualiser votre classement.",
        
        //7- Aide feed-back
        "Faîtes nous directement parvenir vos remarques ou suggestions concernant l'application. Vos retours nous sont précieux afin de vous proposer un service de qualité et une expérience immersive. Choisissez un sujet et tapez simplement votre message. Nous récupèrerons votre adresse email afin d’éventuellement  vous répondre  pour des informations complémentaires. Les remarques les plus pertinentes seront récompensées. ",
        
        
        //8- Aide réglages
        "Dans cette section vous pouvez :\n- changer votre mot de passe\n- activer/désactiver la protection Touch ID si disponible\n- activer/désactiver les bruitages dans Prep'App\n- activer/désactiver les notifications\n- si votre établissement le permet, vous pouvez modifier votre pseudonyme qui paraîtra dans le classement Prep'App. Si vous ne voulez pas être anonyme, vous pourrez toujours mettre votre prénom et nom en tant que pseudonyme.",
        
        
        //9- Mentions légales
        "Editeur :\nPREP’APP - 9 Rue Saint Christophe 44210 PORNIC France\nSAS au capital de 10 000 euros\nImmatriculé à SAINT-NAZAIRE au numéro RCS : 812 143 840\nSIRET : 812 143 840 00013\nTél : +33 (0)7 83 18 06 61\nE-mail : contact@prep-app.com\n\nLa marque verbale « PREP'APP » est une marque déposée à l’Office de l'Harmonisation dans le Marché intérieur (O.H.M.I) par PREP’APP sous le numéro : 014442529.\nLa représentation graphique « P’ » est une marque déposée à l’Office de l'Harmonisation dans le Marché intérieur (O.H.M.I) par PREP’APP sous le numéro : 014351639.\nDirecteur de la publication et responsable de la rédaction : Maximilien Rochaix\n\nHébergeur :\nOVH SAS - 2 rue Kellermann 59100 ROUBAIX\nFrance\nTél : +33 (0)9 72 10 10 07\n\nInformatique et Libertés :\nConformément à la loi du 6 janvier 1978 relative à l'informatique, aux fichiers et aux libertés, PREP'APP a fait l'objet d'une déclaration auprès de la Commission Nationale Informatique et Libertés, numéro : 1898032.\n\nCette app a été développée en Swift à l'aide de ©Realm (base de donnée locale orientée objets), du framework ios-charts, de SWRevealViewController et de SwiftSpinner.\n\nMentions légales de Realm : Realm Objective-C & Realm Swift are published under the Apache 2.0 license. The underlying core is available under the Realm Core Binary License while we work to open-source it under the Apache 2.0 license. This product is not being made available to any person located in Cuba, Iran, North Korea, Sudan, Syria or the Crimea region, or to any other person that is not eligible to receive the product under U.S. law.\n\nMentions légales de ios-charts : Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda. Licensed under the Apache License, Version 2.0 (the \"License\"); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an \"AS IS\" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.\n\nMentions légales SWRevealViewController : Copyright (c) 2013 Joan Lluch joan.lluch@sweetwilliamsl.com Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\nMentions légales SwiftSpinner : Copyright (c) 2015 Marin Todorov <touch-code-magazine@underplot.com> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sellcopies of the Software, and to permit persons to whom the  Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.",
    
    
        //10- CGU
        HelpViewController.getCGU()
        ]
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var roundCircle: UILabel!
    @IBOutlet weak var helpImage: UIImageView!
    @IBOutlet weak var helpText: UITextView!
    @IBOutlet weak var helpTitle: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func changePage(sender: AnyObject) {
        self.selectedHelp = self.pageControl.currentPage
        Sound.playTrack("next")
        self.displayHelp()
    }
    
    static func getCGU() -> String {
        return "Les présentes Conditions Générales d'Utilisation ont pour objet de définir les modalités de mise à disposition de l’Application PREP’APP, ci-après nommée « le Service » et les conditions d'utilisation du Service par l'Utilisateur.\n\n« L’Utilisateur » réfère à toute personne qui utilise l’Application ou l'un des Services proposés par PREP’APP.\n\n« L’Application » réfère au logiciel mobile numérique permettant l’utilisation du Service proposé par PREP’APP. \n\n« Le Contenu Pédagogique » désigne les questions et les corrigés que le Service met à disposition de l’Utilisateur.\n\n« Les Informations » désignent les données fournies ou générées par l'Utilisateur dans les différentes rubriques de l’Application.\n\n« La Communauté » désigne l’ensemble des Utilisateurs du Service PREP’APP ainsi que ses partenaires.\n\nTout document écrit et/ou tout autre condition particulière contenus notamment dans des documents issus de l’Utilisateur ne peut prévaloir sur les présentes Conditions Générales d’Utilisation.\n\nIl est précisé en tant que besoin, que l’Utilisateur peut sauvegarder ou imprimer les présentes Conditions Générales d’Utilisation, à condition toute fois de ne pas les modifier. L’Utilisateur peut en faire la demande en version PDF à l’adresse :\nsupport@prep-app.com\n\nL’Application PREP’APP est accessible gratuitement via une inscription dans un établissement partenaire qui fournit les identifiants d’accès à PREP’APP. L’accès à l’Application est exclusivement réservé aux personnes membres d’un établissement partenaire. Pour y accéder, l'utilisateur doit posséder un support numérique sous iOS 9 minimum (iPhone et iPodTouch) et d’un accès à du WiFi ou à un réseau de données cellulaires (data). Les frais relatifs à ces équipements sont à la charge exclusive de l'Utilisateur.\n\nLe Service PREP’APP met en ligne une Application permettant à l’Utilisateur de tester ses connaissances à travers différents modes d’exercices. Il lui offre un suivi statistique personnel de sa progression.\n\nPREP’APP est le titulaire exclusif des droits intellectuels sur l’Application notamment de l’ensemble des textes, logos, commentaires, illustrations, qu’ils soient visuels ou sonores, exception faite du Contenu Pédagogique.\n\nToute reproduction totale ou partielle des marques ainsi que toute représentation totale ou partielle des marques et/ou logos, effectuées à partir des éléments de l’Application sans l'autorisation expresse de la société PREP’APP est prohibée, au sens de l'article L 713-2 du code de la propriété intellectuelle et peut entraîner des poursuites judiciaires.\n\nLe Contenu Pédagogique quant à lui est la propriété intellectuelle de l’établissement partenaire.\n\nToute reproduction totale ou partielle du Contenu Pédagogique comprenant les questions et les corrigés de l’établissement via l’Application PREP’APP est prohibée, au sens de l’article L713-2 de la propriété intellectuelle, et peut entraîner des poursuites judiciaires. PREP’APP n’assume aucune responsabilité concernant les agissements de ses Utilisateurs car l’élève Utilisateur est seul responsable de toute reproduction, totale ou partielle ainsi que de la distribution de ce Contenu Pédagogique.\n\nL’Utilisateur sera tenu de communiquer certaines informations telles que son nom, son prénom ainsi que son adresse mail afin d’adhérer au Service PREP’APP. Les Informations générées par l’Utilisateur sont mises à disposition du/des professeur(s) référent(s) dans le cadre du suivi collectif. Le Service PREP’APP permet à l’Utilisateur de récolter des points qui seront réutilisables au sein de la Communauté PREP’APP. PREP’APP dispose du droit d'utiliser lesdites Informations dans le cadre du développement futur de ses différentes offres de services et de les transmettre à ses partenaires membres de la Communauté PREP’APP.\nSauf opposition, l’Utilisateur est susceptible de recevoir, des informations commerciales de la part de la Communauté PREP’APP par voie électronique.\nA ce titre, l’Utilisateur pourra exercer son droit d’accès, de modification, de rectification et de suppression des données qui le concernent, étant informé que le Service PREP’APP a fait l’objet d’une déclaration à la CNIL sous le numéro 1926947, et ce conformément à la loi « Informatique et Libertés », nº 7817 du 6 janvier 1978.\n\nPour l'exercer, adressez votre demande par écrit à :\nPREP’APP - 9 Rue Saint Christophe 44210 PORNIC\nEn cas de problèmes avec les renseignements fournis par l’Utilisateur la responsabilité de PREP’APP ne pourra être en aucun cas engagée et l’Utilisateur devra immédiatement informer PREP’APP de cette situation par courriel à l’adresse : support@prep-app.com\nPREP'APP s'efforce d'assurer au mieux l'accès au Service PREP’APP ainsi que l'exactitude et la mise à jour des informations figurant sur l’Application, exception faite du Contenu Pédagogique.\n\nPREP’APP et l’établissement partenaire se réservent le droit de procéder à des mises à jour du Contenu Pédagogique et des fonctionnalités sur l’Application PREP’APP. Ces mises à jour pourront entraîner une indisponibilité temporaire de l’Application. PREP'APP s'engage à mettre tous les moyens en œuvre pour rétablir l'accès au Service PREP’APP dans les meilleurs délais.\n\nLe cas de force majeure désigne tout événement en dehors du contrôle de PREP’APP et contre lequel PREP’APP n’a pu raisonnablement se prémunir.\nPREP’APP n’est pas responsable en cas de manquement à ses obligations, telles que définies dans les présentes CGU résultant d’un cas de force majeure.\n\nPréalablement à toute utilisation l’Utilisateur devra reconnaître expressément avoir pris connaissance des présentes Conditions Générales d’Utilisation en cliquant sur le bouton « J’accepte les CGU».\n\nCompte tenu du caractère électronique du contrat passé entre l’Utilisateur et PREP’APP, cette acceptation n’est en aucune façon conditionnée par une signature manuscrite de la part du client."
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageControl.numberOfPages = self.helpTexts.count
        self.pageControl.currentPage = 0
        if( traitCollection.forceTouchCapability == .Available){
            self.helpTexts[0] += "\n\nUtilisez 3D Touch sur votre iPhone 6S avec Peek & Pop ! Dans l'accueil, appuyez d’une légère pression (Peek) pour afficher l’aperçu de vos statistiques. Relachez pour faire disparaître l'aperçu ou appuyez plus fermement (Pop) pour rentrer dans les statisques détaillées."
            self.helpTexts[5] += "\n\nUtilisez 3D Touch sur votre iPhone 6S avec Peek & Pop ! Dans Actualités, appuyez d’une légère pression (Peek) pour afficher l’aperçu d’une actualité. Relachez pour faire disparaître l'aperçu ou appuyez plus fermement (Pop) pour rentrer dans l'actualité sélectionnée."
            self.helpTexts[7] += "\n\nUtilisez 3D Touch sur votre iPhone 6S avec Peek & Pop ! Appuyez d’une légère pression (Peek) pour afficher l’aperçu de la question marquée. Relachez pour faire disparaître l'aperçu ou appuyez plus fermement (Pop) pour rentrer dans la question marquée et accèder à sa correction si disponible."
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logout", name: "failed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update", name: "update", object: nil)
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Segoe UI", size: 20)!]
        self.navigationController!.navigationBar.tintColor = Colors.greenLogo
        self.title = "Aide"
        if self.revealViewController() != nil {
            self.menuButton.target = self.revealViewController()
            self.menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        //sync
        FactoryHistory.getHistory().sync(){ _ in return }
        self.view!.backgroundColor = Colors.greyBackground
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update", name: "update", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "logout", name: "failed", object: nil)
        //handling swipe gestures
        let swipeRight = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        //load help
        self.displayHelp()
        //designing...
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Segoe UI", size: 20)!]
        self.navigationController!.navigationBar.tintColor = Colors.greenLogo
        self.roundCircle.layer.cornerRadius = 50
        self.roundCircle.backgroundColor = UIColor.clearColor()
        self.roundCircle.layer.borderColor = Colors.greenLogo.CGColor
        self.roundCircle.layer.borderWidth = 3.0

    }
    
    override func viewDidAppear(animated: Bool) {
        self.helpText.setContentOffset(CGPointZero, animated: true)
        self.helpText.scrollRangeToVisible(NSRange(location: 0, length: 0))
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
    
    func swiped(gesture : UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.Left:
                self.selectedHelp = (self.selectedHelp == self.helpTexts.count-1) ? 0 : ++self.selectedHelp
                
            case UISwipeGestureRecognizerDirection.Right:
                self.selectedHelp = (self.selectedHelp == 0) ? self.helpTexts.count-1 : --self.selectedHelp
                
            default:
                print("error")
                break
            }
            
        }
        Sound.playTrack("next")
        self.displayHelp()
    }
    
    func displayHelp() {
        self.pageControl.currentPage = self.selectedHelp
        self.pageControl.updateCurrentPageDisplay()
        self.helpImage.image = UIImage(named: self.helpPics[self.selectedHelp])
        self.helpTitle.text = self.helpTopics[self.selectedHelp].uppercaseString
        self.helpText.text = self.helpTexts[self.selectedHelp]
        self.helpText.textColor = UIColor.blackColor()
        self.helpText.font = UIFont(name: "Segoe UI", size: 16)
        self.helpText.setContentOffset(CGPointZero, animated: true)
        self.helpText.scrollRangeToVisible(NSRange(location: 0, length: 0))
        self.helpText.textAlignment = NSTextAlignment.Justified
        SwiftSpinner.hide()
    }


}
