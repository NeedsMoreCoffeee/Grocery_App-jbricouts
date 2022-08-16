//
//  LoginView.swift
//  Grocery_App
//
//  Created by Brandon Bravos on 8/3/22.
//

import UIKit

protocol LogInDelegate{
    func signUpButtonTapped(isOnLogin loggin: Bool)
    
    func userRegistrationRequestSubmitted()
    
    func userLogInRequestSubmitted()

}


class LoginView: UIView {

    /// the delegate that controls our taps
    public var logInDelegate: LogInDelegate!
    
    // used for our type fields
    private var inputs: [InputTypes] = [ .username, .email, .password, .confirmPassword ]

    // used to tell if our current display is registration or log in
    private var isLoggingIn: Bool = false
    
    // this is used for animating our constraints
    private let animationSpacing: CGFloat = 70 // this is the sum of our UserTypeView height + spacing between views
    
    // used to animate the top anchor of our email view in front of our username typefield
    private var emailTopAnchorContraint: NSLayoutConstraint!
    
    // used to animate the top anchor of our confirm password view in behind of our password typefield
    private var confirmPasswordTopAnchorContraint: NSLayoutConstraint!

    // an array of all our inputs, made with out inpputs: [InputTypes]
    private var inputFields: [UserTypeView]!
    
    // the subviews in this class
    
    // A title: this will say 'Log In' or Register
    private var signInHeaderLabel:UILabel!
    
    // sub title to our sign in header.
    private var welcomeLabel:UILabel!
    
    // a button underneath our input views
    private var forgotPasswordButton: UILabel!
    
    // these two will be converted into one button later, is our 'Sign Up' or 'Log In' Button
    private var signInButton: GradientView!
    private var signInButtonText: UILabel!
    
    // hangs at the bottom of the page, together asks if the user wants to sign up or has an account
    private var noAccountLabel: UILabel!
    private var signUpButton: UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    
    // this is called when the view is first instantiated. Since there's a 'fake' animated splash screen
    // we need to set up our view but without allowing it to show, which is why we keep the alpha to 0 with 'initialized'
    public func initializeLayout(){
        // set isLogging in to true - it's set to false orginally for layout purpouses
        isLoggingIn = true
      
        // called for use of it's layouts. 'shouldReappear: false' simply means to keep the view hidden after adjusting anchors
        animateFadeOutAndBackIn(shouldReappear: false) { self.adjustsAnchors() }
    }
    
    
    // Action from button that controls the transition between 'Log-in' and 'Register'
    @objc private func accountRegistrationButtonPressed(){
        // switch between a log-in form or a register form
        self.isLoggingIn.toggle()
        
        // sets our view based on log-in or sign-up
        setLabelsBasedOnAction()
        
        // reference to our delegate so that our pareent view can adjust itself accordingly
        logInDelegate.signUpButtonTapped(isOnLogin: isLoggingIn)
       
     }
    
    // what to do when sign in button is tapped
    @objc private func signInButtonTapped(){
        isLoggingIn ? logInDelegate.userLogInRequestSubmitted() : logInDelegate.userRegistrationRequestSubmitted()
    }
    
    // MARK: Layout Animations
    
    // this clears our text fields and animates our view transitioning
    private func setLabelsBasedOnAction(){
        clearTextFromInputs()
        animateFadeOutAndBackIn(shouldReappear: true) {
            self.adjustsAnchors()
        }
    }
    
    // fades our view -> whenViewIsHidden{'what to do when hidden'} -> re shows view
    private func animateFadeOutAndBackIn(shouldReappear: Bool, whenViewIsHidden whenHidden: @escaping ()->Void){
        // fade out
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: { self.alpha = 0
        }){ _ in
            // what to when hidden
            whenHidden()
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                // should we re-animate the view
                self.alpha = shouldReappear ? 1 : 0
            }
        }
    }
    
    // hides or shows our username and confirm password fields, the difference between a log-in page or a registration one
    private func adjustsAnchors(){
        emailTopAnchorContraint.constant = self.isLoggingIn ? 0 : self.animationSpacing
        confirmPasswordTopAnchorContraint.constant = self.isLoggingIn ? 0 : self.animationSpacing
        forgotPasswordButton.alpha = self.isLoggingIn ? 1 : 0
        
        // changes our titles, sub titles and text based on if view is log-in or registration
        changeLabelsBasedOnView()
        self.layoutIfNeeded()
    }
    
    // clears our text fields to show the place holders
   private func clearTextFromInputs(){
        for textField in inputFields{
            textField.clearText()
        }
    }
    
    // changes our titles, sub titles and text based on if view is log-in or registration
    private func changeLabelsBasedOnView(){
        signInHeaderLabel.text = isLoggingIn ? "Log In" : "Create New Account"
        welcomeLabel.text = isLoggingIn ? "Welcome!" : "Joining is easy: "
        signInButtonText.text = isLoggingIn ? "Sign In" : "Create Account"
        noAccountLabel.text = isLoggingIn ? "Don't have an account yet?" : "Already a member?"
        signUpButton.setTitle(isLoggingIn ? "Sign Up" :"Sign In", for: .normal)
        forgotPasswordButton.alpha = isLoggingIn ? 1 : 0
    }
    

    
    

    
 
    // MARK: Layout
  
    private func setUpViews(){
        signInHeaderLabel = UILabel()
        signInHeaderLabel.text = "Log In"
        signInHeaderLabel.font = UIFont(name: ProjectThemes.boldDMSans, size: 23)
        signInHeaderLabel.sizeToFit()
        addsView(signInHeaderLabel)
        NSLayoutConstraint.activate([
            signInHeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 44),
            signInHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
         welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome!"
        welcomeLabel.font = UIFont(name: ProjectThemes.regularDMSans, size: 14)
        welcomeLabel.sizeToFit()
        addsView(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: signInHeaderLabel.bottomAnchor, constant: 10),
            welcomeLabel.leadingAnchor.constraint(equalTo: signInHeaderLabel.leadingAnchor)
        ])
        
        createTypeFields()
        
        let inputIndex = inputFields.count - 1
        
        forgotPasswordButton = UILabel()
        forgotPasswordButton.text = "forgot your password?"
        forgotPasswordButton.textColor = ProjectThemes.greenGradientDark
        forgotPasswordButton.font = UIFont(name: ProjectThemes.regularDMSans, size: 14)
        forgotPasswordButton.sizeToFit()
        addsView(forgotPasswordButton)
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: inputFields[inputIndex].bottomAnchor, constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: inputFields[inputIndex].trailingAnchor)
        ])
        
         signInButton = GradientView(isVertical: false)
        signInButton.layer.cornerRadius = 16
        signInButton.clipsToBounds = true
        addsView(signInButton)
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 51),
            signInButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 52),
            signInButton.widthAnchor.constraint(equalToConstant: 213)
        ])
        signInButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.signInButtonTapped)))

        signInButtonText = UILabel()
        signInButtonText.text = "Sign In"
        signInButtonText.textAlignment = .center
        signInButtonText.textColor = .white
        signInButtonText.font = UIFont(name: ProjectThemes.boldDMSans, size: 14)
        signInButtonText.sizeToFit()
        signInButton.addFullView(signInButtonText, parent: signInButton)
        
         noAccountLabel = UILabel()
        noAccountLabel.text = "Don't have an account?"
        noAccountLabel.textColor = .black
        noAccountLabel.font = UIFont(name: ProjectThemes.regularDMSans, size: 14)
        noAccountLabel.sizeToFit()
        addsView(noAccountLabel)
        NSLayoutConstraint.activate([
            noAccountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            noAccountLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -15)
        ])
        
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor( ProjectThemes.greenGradientDark, for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: ProjectThemes.mediumDMSans, size: 14)
        signUpButton.sizeToFit()
        addsView(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: noAccountLabel.trailingAnchor, constant: 2),
            signUpButton.centerYAnchor.constraint(equalTo: noAccountLabel.centerYAnchor),
        ])
        
        signUpButton.addTarget(self, action: #selector(accountRegistrationButtonPressed), for: .touchDown)
        
        
    }
    
 
    // iterates over our input:[InputTypes] - and creates typefields associtated with them
    func createTypeFields(){
        var trailingYInsert: NSLayoutYAxisAnchor?
        var initialSeperation:CGFloat = 25
        if trailingYInsert == nil{
            trailingYInsert = welcomeLabel.bottomAnchor
        }
        
        inputFields = []
        
        // code that adds type views with a loop
        for (index, tab)  in inputs.enumerated() {
            let typeView = UserTypeView()
            typeView.setInputView(placeHolederText: tab.rawValue, textFieldAssociatedIcon: tab.icon)
            typeView.tag = index
            addsView(typeView)
            NSLayoutConstraint.activate([
             typeView.leadingAnchor.constraint(equalTo: leadingAnchor),
             typeView.trailingAnchor.constraint(equalTo: trailingAnchor),
             typeView.heightAnchor.constraint(equalToConstant: 54)
            ])
            
            // set the emailtopconstraint so that it can be use to hide .username typeField
            if tab == .email {
                emailTopAnchorContraint = typeView.topAnchor.constraint(equalTo: inputFields[0].topAnchor, constant: animationSpacing)
                emailTopAnchorContraint.isActive = true
            }
            // set the confirm password type view top constraint to a variable so that is can be used to hide underneath our password typpview
            else if tab == .confirmPassword{
                confirmPasswordTopAnchorContraint = typeView.topAnchor.constraint(equalTo: inputFields[2].topAnchor, constant: animationSpacing)
                confirmPasswordTopAnchorContraint.isActive = true
            }else{
                typeView.topAnchor.constraint(equalTo: trailingYInsert!, constant: initialSeperation).isActive = true

            }
            
            inputFields.append(typeView)
            trailingYInsert = typeView.bottomAnchor
            initialSeperation = 16
        }
        
        // we bring our 2nd input view (our password type view) to the fron so that it can hide our confirmed password
        bringSubviewToFront(inputFields[2])
    
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// an enum that will have our type field types, and return an image associated with the type

fileprivate enum InputTypes: String, CaseIterable {
   case username = "Username"
   case email = "Email"
   case password = "Password"
   case confirmPassword = "Confirm Password"
   
   /// the icon associated with our enum
   var icon: UIImage {
       switch self {
       case .username:
           return UIImage(named: "profile_icon")!
       case .email:
           return UIImage(named: "email_icon")!
       case .password:
           return UIImage(named: "password_icon")!
       case .confirmPassword:
           return UIImage(named: "password_icon")!
       }
   }
    
    var displayTitle: String {
            return self.rawValue.capitalized(with: nil)
        }
        
    }
