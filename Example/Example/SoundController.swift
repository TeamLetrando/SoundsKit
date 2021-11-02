//
//  ViewController.swift
//  Example
//
//  Created by PATRICIA S SIQUEIRA on 11/10/21.
//

import UIKit
import SoundsKit

class SoundController: UIViewController, UITextFieldDelegate {
    
    var speech: String = ""
    
    lazy var textField:UITextField = {
        let textField =  UITextField(frame: CGRect(x: self.view.center.x - 100, y: self.view.center.y - 200, width: 200, height: 50))
        textField.placeholder = "Palavra em português"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }()
    
    lazy var soundButton:UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: self.view.center.x - 50, y: self.view.center.y - 100, width: 100, height: 70)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.tintColor = .black
        button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        SoundsKit.audioIsOn() ? try? SoundsKit.play() : SoundsKit.pause()
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        textField.delegate = self
        self.view.addSubview(soundButton)
        self.view.addSubview(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let speech = textField.text else {return}
        SoundsKit.reproduceSpeech(speech)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @objc func buttonAction(sender: UIButton!) {
        if SoundsKit.audioIsOn() {
            sender.setBackgroundImage(UIImage(systemName: "stop.circle"), for: .normal)
            SoundsKit.pause()
        } else {
            sender.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
            try? SoundsKit.play()
        }
        
    }
    
    
}

