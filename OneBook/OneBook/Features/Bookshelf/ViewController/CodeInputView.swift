//
//  CodeInputView.swift
//  OneBook
//
//  Created by weixin on 2024/1/10.
//

import UIKit

class CodeInputView: UIView, UITextFieldDelegate {
    
    private let PhoneTFLength = 20
    
    private lazy var inputText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入密码，注意不分大小写"
        textField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textViewChange), name: UITextField.textDidChangeNotification, object: nil)
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        self.addSubview(inputText)
        inputText.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc fileprivate func textViewChange() {
        let targetCursorPosition = inputText.offset(from: inputText.beginningOfDocument, to: inputText.selectedTextRange?.start ?? inputText.beginningOfDocument)
        
        var pasteText = inputText.text ?? ""
        // 移除空格并拼接新字符串
        let digits = pasteText.replacingOccurrences(of: " ", with: "")
        var processedText = ""
        let groupSize = 4
        
        // 按照每4位添加空格
        for (index, char) in digits.enumerated() {
            if index > 0 && index % groupSize == 0 {
                processedText.append(" ") // 在每4位数字后添加空格
            }
            processedText.append(char)
        }
        
        var editFlag: Int = 0
        if pasteText.count <= processedText.count {
            editFlag = 0
        } else {
            editFlag = 1
        }
        
        let newText = processedText
                    
        inputText.text = newText // 更新UITextField的文本内容
        
        var curTargetCursorPosition = targetCursorPosition
        
        if targetCursorPosition % (groupSize + 1) == 0 {
            curTargetCursorPosition += (editFlag == 0) ? -1 : 1
        }
        
        if targetCursorPosition == digits.count {
            let targetCursorPositions = inputText.offset(from: inputText.beginningOfDocument, to: inputText.selectedTextRange?.start ?? inputText.beginningOfDocument)
            curTargetCursorPosition = targetCursorPositions
        }
    
        DispatchQueue.main.async {
            if let targetPosition = self.inputText.position(from: self.inputText.beginningOfDocument, offset: curTargetCursorPosition) {
                self.inputText.selectedTextRange = self.inputText.textRange(from: targetPosition, to: targetPosition)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            return true // 返回true表示继续处理其他操作
        }
}

