//
//  ViewController.swift
//  Ettizan_ios
//
//  Created by Abdilrahman Gamal on 27/11/2023.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var outlinedTextField : UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()

        // قم بإعداد المراقب للحقل النصي
        outlinedTextField = createOutlinedTextField(placeholder: "Enter text")
        outlinedTextField?.delegate = self // اجعل الـ ViewController مراقبًا للحقل النصي
        // أضف الحقل النصي إلى واجهة المستخدم
      //  outlinedTextField?.backgroundColor = .blue
        outlinedTextField?.frame = CGRect(x: 100, y: 100, width: 200, height: 80)
        
//        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: self.outlinedTextField?.size.height ?? 0))
//        outlinedTextField?.leftView = paddingView

        
        
        view.addSubview(outlinedTextField!)
    }

    // دالة تُدعى عندما يقوم المستخدم بالتركيز على الحقل النصي
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // تحقق مما إذا كان الحقل النصي يتطابق مع الحقل النصي الذي ترغب في تنفيذ ظهوره عند التركيز عليه
        if textField == outlinedTextField {
            // قم بتغيير حالة الحقل النصي عن طريق تعيين الخصائص المناسبة هنا (مثلاً، قم بتغيير اللون أو الحدود)
            textField.layer.borderColor = UIColor.blue.cgColor
        }
    }

    // دالة تُدعى عندما يفقد الحقل النصي التركيز
    func textFieldDidEndEditing(_ textField: UITextField) {
        // تحقق مما إذا كان الحقل النصي يتطابق مع الحقل النصي الذي ترغب في تنفيذ ظهوره عند التركيز عليه
        if textField == outlinedTextField {
            // إعادة الحقل النصي إلى الحالة الأصلية عندما يفقد التركيز
            textField.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    // الدالة التي تُستخدم لإنشاء حقل النص المحدد الحدود
    func createOutlinedTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.masksToBounds = true

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        return textField
    }
}
