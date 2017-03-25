//
//  SettingsViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 22/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit

enum SettingTypes: String{
    case coloScheme = "colorscheme"
    case autoPlay = "autoplay"
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var scColorScheme: UISegmentedControl!
    @IBOutlet weak var swAutoPlay: UISwitch!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }
    
    @IBAction func changeAutoPlay(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn,forKey: SettingTypes.autoPlay.rawValue)
    }
    @IBAction func changeColorScheme(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex,forKey: SettingTypes.coloScheme.rawValue)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scColorScheme.selectedSegmentIndex = UserDefaults.standard.integer(forKey: SettingTypes.coloScheme.rawValue)
        swAutoPlay.setOn(UserDefaults.standard.bool(forKey: SettingTypes.autoPlay.rawValue), animated: false)
        
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}






