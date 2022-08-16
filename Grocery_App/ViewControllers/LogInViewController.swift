//
//  ViewController.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/2/22.
//

import UIKit


// this is our Initital view. It is built into two parts:
// Phase One: A fake splash screen
// Phase Two: The splash screen disapears to show a logInView, which can transition between a log in our a registration form

class LogInViewController: UIViewController {

    // our logo label, a place holder for a logo.
    private var logoLabel: UILabel!
    
    // this is used to animate our top constraint
    private var topConstraintConstant: CGFloat = 135

    // reference to the leading constraint of our logo. used from transitioning logoLabel from center of view to left
    private var logoLeadingConstraint: NSLayoutConstraint!
    
    // used to animate the top of our logo label, changes when splash screen finishes, and when log in form is switched between log--in and registration
    private  var logoTopConstraint: NSLayoutConstraint!

    // the animated title used in our fake splash screen. Fades in and out, marking the end ouf our fake splash screen
    private var subTitleLabel: UILabel!
    
    // this is a custom view used to make a gradient background for our fake splash screen. It fades out to show log in view
    private var gradientView: GradientView!

    // a view that animates and changes between a registration view and a sign in view
    private var logInView: LoginView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // sets up everything from our main logo, to our hidden sign in view
        setUpView()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // used to animate fake splash screen
        animateView()
    }

    // MARK: Methods
    
    // what to do when trying to create a new user
    private func registerNewUser(){
        print("attempting to register new user")

    }
    
    // what to do when logging in
    private func logInExistingUser(){
        print("attempting to log-in existing user")
        let homeViewController = HomeViewController()
        self.navigationController?.pushViewController(homeViewController, animated: true)

        

    }
  
    
     
}

// MARK: Delegates
// reference to our logInView delegate which says what is pressed and what state the view is in
extension LogInViewController: LogInDelegate{
    
    // called when the log in views regiser button tapped
    func userRegistrationRequestSubmitted() {
        self.registerNewUser()
    }
    
    // called when the log in views log in button tapped
    func userLogInRequestSubmitted() {
        self.logInExistingUser()

    }
    
    
    // what to do when register / go back to log-in button is pressed
    func signUpButtonTapped(isOnLogin loggin: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn){
            // adjust the top logo. If the view is in registration mode, we raise it up, if not, return it
            self.logoTopConstraint.constant = !loggin ? 50 : self.topConstraintConstant
            self.view.layoutIfNeeded()
        }
    }
    
    
    
}












// MARK: Layout
extension LogInViewController{
    
    // this is what sets up our view
    func setUpView(){
        
        self.view.backgroundColor = .white
        // adds the gradient color to the background
        gradientView = GradientView(isVertical: true)
        view.addFullView(gradientView, parent: view)
        
        // adds the logo title to the view
        addLogoLabel()
        
        addSighInLayout()
        
        // adds the subtitle text
        addSubTitleText()
        
        // adds visual design circles to our view
        addCircles()
        
        logInView.initializeLayout()

    }
    
    // adds the logo label
    func addLogoLabel(){
        let screenSize = UIScreen.main.bounds
        logoLabel = UILabel()
        logoLabel.textColor = .white
        logoLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 70)
        logoLabel.sizeToFit()
        logoLabel.text = "logo"
        view.addsView(logoLabel)
        logoLeadingConstraint = logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: screenSize.width/2 - 70 )
        logoTopConstraint = logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenSize.height/2 - 45)
        
        NSLayoutConstraint.activate([logoLeadingConstraint, logoTopConstraint])
        
    }
    
    // this adds the splash screen description
    func addSubTitleText(){
        subTitleLabel = UILabel()
        subTitleLabel.alpha = 0
        subTitleLabel.textColor = ProjectThemes.lightGreenSubTextColor
        subTitleLabel.sizeToFit()
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont(name: ProjectThemes.regularDMSans, size: 17)
        subTitleLabel.text = "Market in 15 minutes"
        view.addsView(subTitleLabel)
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 19),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func addSighInLayout(){
        logInView = LoginView()
        logInView.logInDelegate = self
        logInView.backgroundColor = .clear
        view.addsView(logInView)
        NSLayoutConstraint.activate([
            logInView.topAnchor.constraint(equalTo: logoLabel.bottomAnchor),
            logInView.leadingAnchor.constraint(equalTo: logoLabel.leadingAnchor),
            logInView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            logInView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        
        logInView.alpha = 0
    }
    
    // adds designer circles in the top right corner of the view
    func addCircles(){
        let screenSizeModifier = UIScreen.main.bounds.width/2
        let circleColor = ProjectThemes.lightGreenSubTextColor
        let circleView = CircularDesignView(circleColor: circleColor)
        circleView.alpha = 0.3
        view.addsView(circleView)
        NSLayoutConstraint.activate([
            circleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: screenSizeModifier/3),
            circleView.topAnchor.constraint(equalTo: view.topAnchor, constant: -screenSizeModifier/2.5),
            circleView.widthAnchor.constraint(equalToConstant: screenSizeModifier),
            circleView.heightAnchor.constraint(equalToConstant: screenSizeModifier),


        ])
        circleView.animateCircle(duration: 3)
    }
    
    //MARK: ANIMATONS

    // this shows the subtitle label in our fake splash screen, then fades it away
    func animateView(){
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn, animations: {
            self.subTitleLabel.alpha = 1
        }, completion: { _ in
            self.hideSubtitle()
        })

     
       
    }
  
    // hides the subtitle. Then officially ends our fake splash screen
    private func hideSubtitle(){
        UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseIn, animations: {
            self.subTitleLabel.alpha = 0
            
        }, completion: { _ in
            self.transitionToSignInAnimation()
        })
       
        
     
        
    }
   
    // this changes the view from our fake splash screen to our log in / register view
    func transitionToSignInAnimation(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            // move our logo title to top of view
            self.logoTopConstraint.constant = self.topConstraintConstant
            
            // uncenter our logo title and have it lead on the left
            self.logoLeadingConstraint.constant = 45
            
            // hide our splash screen background
            self.gradientView.alpha = 0
            
            self.changeTitleColor()
            
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
               
                // show our log in / registration view
                self.logInView.alpha = 1
                
            }, completion: {_ in })
        })
    }
    
    
    // changes our logoLabels color.
    func changeTitleColor(){
        UIView.transition(with: self.logoLabel, duration: 0.5, options: .transitionCrossDissolve) {
            self.logoLabel.textColor = ProjectThemes.greenGradientDark
            self.logoLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 57)
        }
    }
    
    
}
