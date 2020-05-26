//
//  ViewController.swift
//  tweetMood
//
//  Created by lpiem on 14/11/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myPicker: UIPickerView!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnTwitter: UIButton!
    
    //weak open var dataSource: UIPickerViewDataSource?
    //weak open var delegate: UIPickerViewDelegate?
    
    let tabMood: [String] = ["galère", "mange", "cours", "suis en cours", "développe"]
    let tabSmiley: [String] = ["😍", "👍", "🥰", "💩", "🏃‍♂️"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //self.hideKeyboardWhenTappedAround()

    }
        
    @IBAction func btnTweetItClick(_ sender: Any) {
        let rowMood = self.myPicker.selectedRow(inComponent: 0)
        let moodValue: String = tabMood[rowMood]
        
        let rowSmiley = self.myPicker.selectedRow(inComponent: 1)
        let smileyValue: String = tabSmiley[rowSmiley]
        
        let txtMessageValue: String! = txtMessage.text
        let text: String = "\(txtMessageValue!) Je \(moodValue) \(smileyValue)"
        
        let items: [String] = [text]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
        activityVC.completionWithItemsHandler = {
            activity, success, items, error in
            let message: String
            if(success) {
                message = "Votre message a bien été envoyé"
            }
            else {
                message = "Vous avez annulé l'envoi du message"
            }
            let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok!", style: .default, handler: { (_) in
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
}
// MARK: - Picker View Delegate
extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        switch component {
        case 0:
            return tabMood[row]
        case 1:
            return tabSmiley[row]
        default:
            return ""
        }
    }
    
}
// MARK: - Picker View Data Source
extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return tabMood.count
        case 1:
            return tabSmiley.count
        default:
            return 0
        }
    }
}

// Put this piece of code anywhere you like
/*extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}*/
