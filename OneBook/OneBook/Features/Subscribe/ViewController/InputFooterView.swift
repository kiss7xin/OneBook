//
//  InputFooterView.swift
//  OneBook
//
//  Created by weixin on 2023/10/20.
//

import Foundation
import UIKit

class InputFooterView: UIView, UITextViewDelegate {
    
    var newMsgBlock: ((String) -> Void)?
    var heightChangeBlock: ((CGFloat) -> Void)?
    // 必须设置
    var maxWidth: CGFloat = 0
    var maxLength: Int = 50
    var font: UIFont = UIFont.systemFont(ofSize: 13) {
        didSet {
            self.textView.font = font
        }
    }
    var textColor: UIColor = UIColor.black {
        didSet {
            self.textView.textColor = textColor
        }
    }
    var placeHolderFont: UIFont = UIFont.systemFont(ofSize: 13) {
        didSet {
            placeHolderLab.font = placeHolderFont
        }
    }
    var placeHolderTextColor: UIColor = UIColor.orange {
        didSet {
            placeHolderLab.textColor = placeHolderTextColor
        }
    }
    var text: String = "" {
        didSet {
            if text != self.textView.text {
                self.textView.text = text
                textViewDidChange(self.textView)
            }
        }
    }
    
    var placeHolderText: String = "" {
        didSet {
            placeHolderLab.text = placeHolderText
        }
    }
    
    private var line: Int = 1
    private var currentHeight: CGFloat = 0.0
    
    private lazy var textView: UITextView = {
        let view = UITextView(frame: .zero)
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0
        view.textAlignment = .right
        view.delegate = self
        view.backgroundColor = .clear
        return view
    }()
    
    // 预置lab
    private lazy var placeHolderLab: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        textView.textColor = self.textColor
        textView.font = self.font
        placeHolderLab.textColor = self.placeHolderTextColor
        placeHolderLab.font = self.placeHolderFont
        self.addSubview(textView)
        self.addSubview(placeHolderLab)
        
        self.currentHeight = oneHeight()
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(currentHeight).priority(.high)
        }
        placeHolderLab.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    // UITextFieldDelegate
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if range.location >= maxLength {
            textView.resignFirstResponder()
            return false
        }
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //当前文字变化
        let searchStr = textView.text ?? ""
        
        placeHolderLab.isHidden = searchStr.count > 0
        
        if searchStr.count > maxLength {
            let result:Substring = searchStr.prefix(maxLength)
            textView.text = String(result)
        }
        guard let msg = textView.text else {
            return
        }
        
        // 计算高度
        let moreHeight = searchStr.getHeight(font: self.font , width: self.maxWidth, fontMultiple: 1.2)
        let oneHeight = oneHeight()
        let i = moreHeight / oneHeight
        var currentLine = 1
        if i == 1 {
            currentLine = 1
            textView.textAlignment = .right
        } else {
            currentLine = Int(ceil(i))
            textView.textAlignment = .left
        }
        if currentLine != line  {
            textView.snp.updateConstraints { make in
                make.height.equalTo(moreHeight).priority(.high)
            }
            self.heightChangeBlock?(moreHeight)
        }
        line = currentLine
        // 刷新外部高度
        self.newMsgBlock?(msg)
    }
    
    func oneHeight() -> CGFloat {
        return "哈哈".getHeight(font: self.font, width: textView.frame.width, fontMultiple: 1.2)
    }
}

extension String {
    func getHeight(font: UIFont, width: CGFloat, fontMultiple: CGFloat = 1.4) -> CGFloat {
        
        let constraint = CGSize(width: width, height: 20000.0)
        let lineHeight = font.pointSize * fontMultiple
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.minimumLineHeight = lineHeight
        // 由于这个方法计算字符串的大小的通过取得字符串的size来计算, 如果你计算的字符串中包含\n\r 这样的字符，也只会把它当成字符来计算。但是在显示的时候就是\n是转义字符，那么显示的计算的高度就不一样了,需要进一步处理
        let nString = NSString(string: self)
        let size = nString.boundingRect(with: constraint, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.paragraphStyle : paragraphStyle], context: nil)
        
        let totalHeight = ceil(size.height)
        
        return totalHeight
    }
}
