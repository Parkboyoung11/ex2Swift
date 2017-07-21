import UIKit



class ViewController: UIViewController {
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtKata1: UITextField!
    @IBOutlet weak var txtKata2: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    let datePicker = UIDatePicker()
    
    var gender : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatDatePicker()
        creatDoneButton4Keyboard()
        self.hideKeyboardWhenTappedAround()
        self.txtPhone.delegate = self
        self.txtKata1.delegate = self
        self.txtKata2.delegate = self
    }
    
    
    
    func creatDatePicker(){
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(pressDone))
        toolbar.setItems([doneButton], animated: false)
        txtDate.inputAccessoryView = toolbar
        txtDate.inputView = datePicker
    }
    
    func pressDone(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        txtDate.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func creatDoneButton4Keyboard(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneisPressed))
        toolbar.setItems([doneButton], animated: false)
        txtFirstName.inputAccessoryView = toolbar
        txtLastName.inputAccessoryView = toolbar
        txtKata1.inputAccessoryView = toolbar
        txtKata2.inputAccessoryView = toolbar
        txtEmail.inputAccessoryView = toolbar
        txtPhone.inputAccessoryView = toolbar
    }
    
    func doneisPressed(){
        self.view.endEditing(true)
    }
    
    @IBAction func btnCheckMale(_ sender: Any) {
        btnMale.setImage(UIImage.init(named: "check"), for: .normal)
        btnFemale.setImage(UIImage.init(named: "uncheck"), for: .normal)
        gender = "Male"
    }
    
    @IBAction func btnCheckFemale(_ sender: Any) {
        btnFemale.setImage(UIImage.init(named: "check"), for: .normal)
        btnMale.setImage(UIImage.init(named: "uncheck"), for: .normal)
        gender = "Female"
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        let name : String = txtFirstName.text! + " " + txtLastName.text!
        let kata1 : String = txtKata1.text!
        let kata2 : String = txtKata2.text!
        let phone : String = txtPhone.text!
        let date : String = txtDate.text!
        
        let mail : String = txtEmail.text!
        let emailChecked = mail.checkEmail(mail: mail)
        //let kata1Checked = kata1.checkKataKana(kata: kata1)
        //let kata2Checked = kata2.checkKataKana(kata: kata2)
        //print(kata)
        //print(kataChecked)
        
        //if !kata1Checked || !kata2Checked{
        //    let noti = UIAlertController(title: "Warning", message: "KataKana is not valid!", preferredStyle: .alert)
        //    let btn = UIAlertAction(title: "OK", style: .default, handler: nil)
        //    noti.addAction(btn)
        //    present(noti, animated: true, completion: nil)
        //}
        if !emailChecked{
            let noti = UIAlertController(title: "Warning", message: "Email address is not valid!", preferredStyle: .alert)
            let btn = UIAlertAction(title: "OK", style: .default, handler: nil)
            noti.addAction(btn)
            present(noti, animated: true, completion: nil)
        }
        else if name == "" || kata1 == "" || kata2 == "" || phone == "" || mail == "" || gender == "" || date == "" {
            let noti = UIAlertController(title: "Warning", message: "Please fill all !", preferredStyle: .alert)
            let btn = UIAlertAction(title: "OK", style: .default, handler: nil)
            noti.addAction(btn)
            present(noti, animated: true, completion: nil)
        }
        else{
            let message = name + "\n" + kata1 + " " + kata2 + "\n" + mail + "\n" + date + "\n" + gender + "\n" + phone
            let registed = UIAlertController(title: "Succeeded" , message: message, preferredStyle: UIAlertControllerStyle.alert)
            registed.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(registed, animated: true, completion: nil)
            txtFirstName.text = ""
            txtLastName.text = ""
            txtKata1.text = ""
            txtKata2.text = ""
            txtPhone.text = ""
            txtDate.text = ""
            txtEmail.text = ""
            btnFemale.setImage(UIImage.init(named: "uncheck"), for: .normal)
            btnMale.setImage(UIImage.init(named: "uncheck"), for: .normal)
            gender = ""
        }
    }
    
}

extension String{
    func checkEmail(mail: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: mail)
    }
    
    func checkKataKana(kata: String) -> Bool{
        let kataRegEx = "[ァ-ンー]{0,}"
        //let kataRegEx = "[あ-ん]{0,}"
        let kataTest = NSPredicate(format: "SELF MATCHES %@", kataRegEx)
        return kataTest.evaluate(with: kata)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if textField == txtPhone {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        return string.checkKataKana(kata: string)
    }
}

