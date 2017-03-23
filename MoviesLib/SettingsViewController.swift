//
//  SettingsViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 22/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var swColor: UISwitch!
    @IBOutlet weak var tfName: UITextField!
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.bool(forKey: "Color"){
            view.backgroundColor = .white
        }else{
            view.backgroundColor = .yellow
        }
        
        if let name = UserDefaults.standard.string(forKey: "Name"){
            tfName.text = name
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    @IBAction func chengeColor(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "Color")
    }

  

}

extension SettingsViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        UserDefaults.standard.set(textField.text, forKey: "Name")
    }
}
