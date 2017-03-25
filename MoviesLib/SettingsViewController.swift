//
//  SettingsViewController.swift
//  MoviesLib
//
//  Created by Usuário Convidado on 22/03/17.
//  Copyright © 2017 EricBrito. All rights reserved.
//

import UIKit
import CoreMotion

enum SettingTypes: String{
    case coloScheme = "colorscheme"
    case autoPlay = "autoplay"
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var scColorScheme: UISegmentedControl!
    @IBOutlet weak var swAutoPlay: UISwitch!
    
    @IBOutlet weak var ivBackgroud: UIImageView!
    @IBOutlet weak var tfFood: UITextField!
    
    
    var picker: UIPickerView!

    var dataSource = ["Arroz",
                      "Feijào",
                      "Ovo",
                      "Peixe"
    ]
        var motionManager = CMMotionManager()
    @IBOutlet weak var tfComida: UITextField!
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker = UIPickerView()
        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self
        tfFood.inputView = picker
        
        let toolBack = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBack.items = [btCancel,space,btDone]
        tfFood.inputAccessoryView = toolBack
        if motionManager.isDeviceMotionAvailable{
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (data: CMDeviceMotion?, error: Error?) in
                if error != nil{
                    if let data = data{
                        let angle = atan2(data.gravity.x, data.gravity.y)
                        self.ivBackgroud.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
                    }
                }
            })
        }
        //picker.selectedRow(inComponent: 0)
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
    func cancel(){
        tfFood.resignFirstResponder()
    }
    func done(){
        tfFood.text = dataSource[ picker.selectedRow(inComponent: 0)]
        cancel()
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}

extension SettingsViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Acabaram de comer",dataSource[row])
    }
    
}
extension SettingsViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
}






