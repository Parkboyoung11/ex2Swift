//
//  ViewController.swift
//  ex2
//
//  Created by admin on 7/11/17.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtKata1: UITextField!
    @IBOutlet weak var txtKata2: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDay: UITextField!
    @IBOutlet weak var txtMonth: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtPhone: UITextField!

    
    @IBAction func btnRegister(_ sender: Any) {
        let name : String = txtFirstName.text! + " " + txtLastName.text!
        let kata : String = txtKata1.text! + " " + txtKata2.text!
        let time : String = txtDay.text! + "-" + txtMonth.text! + "-" + txtYear.text!
        let phone : String = txtPhone.text!
        
        let mail : String = txtEmail.text!
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let emailChecked = emailTest.evaluate(with: mail)
        if emailChecked == false {
            let noti = UIAlertController(title: "Warning", message: "Email format isn't correct !", preferredStyle: .alert)
            let btn = UIAlertAction(title: "OK", style: .default, handler: nil)
            noti.addAction(btn)
            present(noti, animated: true, completion: nil)
        }
        
        if name == "" || kata == "" || time == "" || phone == "" || mail == "" {
            let noti = UIAlertController(title: "Warning", message: "Please fill all !", preferredStyle: .alert)
            let btn = UIAlertAction(title: "OK", style: .default, handler: nil)
            noti.addAction(btn)
            present(noti, animated: true, completion: nil)
        }
        else{
            let message = name + "\n" + kata + "\n" + mail + "\n" + time + "\n" + phone
            let registed = UIAlertController(title: "Succeeded" , message: message, preferredStyle: UIAlertControllerStyle.alert)
            registed.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(registed, animated: true, completion: nil)
            txtFirstName.text = ""
            txtLastName.text = ""
            txtKata1.text = ""
            txtKata2.text = ""
            txtDay.text = ""
            txtMonth.text = ""
            txtYear.text = ""
            txtPhone.text = ""
            txtEmail.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

