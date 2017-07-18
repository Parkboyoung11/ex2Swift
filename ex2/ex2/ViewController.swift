import UIKit

extension String{
    func checkEmail(mail: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: mail)
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
        self.hideKeyboardWhenTappedAround()
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
        let kata : String = txtKata1.text! + " " + txtKata2.text!
        let phone : String = txtPhone.text!
        let date : String = txtDate.text!
        
        let mail : String = txtEmail.text!
        let emailChecked = mail.checkEmail(mail: mail)
        if !emailChecked {
            let noti = UIAlertController(title: "Warning", message: "Email format isn't correct !", preferredStyle: .alert)
            let btn = UIAlertAction(title: "OK", style: .default, handler: nil)
            noti.addAction(btn)
            present(noti, animated: true, completion: nil)
        }
        else if name == "" || kata == "" || phone == "" || mail == "" || gender == "" || date == "" {
            let noti = UIAlertController(title: "Warning", message: "Please fill all !", preferredStyle: .alert)
            let btn = UIAlertAction(title: "OK", style: .default, handler: nil)
            noti.addAction(btn)
            present(noti, animated: true, completion: nil)
        }
        else{
            let message = name + "\n" + kata + "\n" + mail + "\n" + date + "\n" + gender + "\n" + phone
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

