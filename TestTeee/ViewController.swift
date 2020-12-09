//
//  ViewController.swift
//  TestTeee
//
//  Created by 김종권 on 2020/12/09.
//

import UIKit
import AnyFormatKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self

    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard var text = textField.text else {
            return false
        }
        let characterSet = CharacterSet(charactersIn: string)
        if CharacterSet.decimalDigits.isSuperset(of: characterSet) == false {
            return false
        }

        let newLength = text.count + string.count - range.length

        if (range.length == 2 || range.length == 4) && string.isEmpty { // 2개 이상 선택하여 삭제하는 경우
            textField.text = ""
            return false
        }

        let formatter = DefaultTextInputFormatter(textPattern: "##**", patternSymbol: "#")
        if newLength == 2 {
            text += " "
        }
        let result = formatter.formatInput(currentText: text, range: range, replacementString: string)
        textField.text = result.formattedText
        let position = textField.position(from: textField.beginningOfDocument, offset: result.caretBeginOffset)!
        textField.selectedTextRange = textField.textRange(from: position, to: position)
        return false

    }
}
