//
//  ViewController.swift
//  UITextFieldFader
//
//  Created by Alex Gibson on 1/16/17.
//  Copyright © 2017 Alex Gibson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slidingTexfield: UITextField!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //set initial placeholder
        resetPlaceHolder(textfield: textField, placeHolder: "I Fade")
        resetPlaceHolder(textfield: slidingTexfield, placeHolder: "I slide")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.endEditingOnTextfield))
        view.addGestureRecognizer(tap)
        
        textField.tintColor = UIColor.white
        slidingTexfield.tintColor = UIColor.white
    }
    
    //called on tap on the view to end editing
    func endEditingOnTextfield(){
        textField.resignFirstResponder()
        slidingTexfield.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func textfieldDidBeginEdit(_ sender: Any) {
        guard let tf = sender as? UITextField else{return}
        if tf.text?.isEmpty == false{
            return
        }
        switch tf {
        case textField:
            resetPlaceHolder(textfield: textField, placeHolder: "")
            fadeTextviewPlaceholder()
            return
        case slidingTexfield:
            resetPlaceHolder(textfield: slidingTexfield, placeHolder: "")
            slideTextviewPlaceholder()
            return
        default:
            return
        }

    }
    

    @IBAction func textfieldDidEndEdit(_ sender: Any) {
        guard let tf = sender as? UITextField else{return}
        if tf.text?.isEmpty == false{
            return
        }
        
        switch tf {
        case textField:
            resetPlaceHolder(textfield: textField, placeHolder: "I Fade")
            fadeTextviewPlaceholder()
            return
        case slidingTexfield:
            resetPlaceHolder(textfield: slidingTexfield, placeHolder: "I slide")
            slideTextviewPlaceholderBack()
            return
        default:
            return
        }
        
    }
    
    func resetPlaceHolder(textfield:UITextField,placeHolder:String){
        let str = placeHolder
        let attibutedText = NSAttributedString(string: str, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 32),NSForegroundColorAttributeName:UIColor.white])
        textfield.attributedPlaceholder = attibutedText
    }
    
    //MARK : Animations
    //These are magical and one of my favorite classes ever created.  Learn to use them on layers and you will see how powerful they are.  
    //you can add them to the window as well.  Cheers
    func fadeTextviewPlaceholder(){
        let fade = CATransition()
        fade.type = kCATransitionFade
        fade.duration = 0.7
        textField.layer.add(fade, forKey: nil)
    }
    
    func slideTextviewPlaceholder(){
        
        let slide = CATransition()
        slide.type = kCATransitionPush
        slide.subtype = kCATransitionFromRight
        slide.duration = 0.5
        slidingTexfield.layer.add(slide, forKey: nil)
    }
    
    func slideTextviewPlaceholderBack(){
        let slide = CATransition()
        slide.type = kCATransitionPush
        slide.subtype = kCATransitionFromLeft
        slide.duration = 0.5
        slidingTexfield.layer.add(slide, forKey: nil)
    }

}

