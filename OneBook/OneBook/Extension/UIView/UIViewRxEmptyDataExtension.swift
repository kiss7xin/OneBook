//
//  UIViewRxEmptyDataExtension.swift
//  OneBook
//
//  Created by weixin on 2021/8/24.
//

import UIKit
import RxSwift
import RxCocoa

final class EmptyResultView: UIView {
    
    private lazy var imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 124)))
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 77, height: 40)
        button.layer.cornerRadius = 40 / 2
        button.setTitle("重试", for: .normal)
        return button
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        addGestureRecognizer(tap)
        return tap
    }()
    
    private lazy var defaultAttributes: [NSAttributedString.Key : Any] = [
        .foregroundColor: GlobalPicker.accentColor,
        .font: UIFont.systemFont(ofSize: 14)
    ]
    
    /// 空页面内容区域，默认-64
    private var contentView: UIView?
    
    private lazy var defaultEmptyDataText = "暂无数据，先去看看别的吧！"
    private lazy var defaultLoadFailedText = "获取数据失败，请稍后再试"
    
    private weak var containerView: UIView?
    
    init(containerView: UIView?) {
        self.containerView = containerView
        super.init(frame: .zero)
        backgroundColor = containerView?.backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var currentResult: EmptyResult = .removed
    
    func setResult(_ result: EmptyResult) {
        currentResult = result
        
        guard let containerView = containerView else { return }
        guard !result.isRemoved else {
            removeFromSuperview()
            return
        }
        
        contentView = nil
        
        subviews.forEach { $0.removeFromSuperview() }
        imageView.removeFromSuperview()
        label.removeFromSuperview()
        retryButton.removeFromSuperview()
        
        var subviews: [UIView] = []
        
        func handleTextStyle(_ textStyle: EmptyResult.TextStyle, isFailed: Bool) {
            switch textStyle {
            case .none: break
                
            case .default:
                label.text = isFailed ? defaultLoadFailedText : defaultEmptyDataText
                subviews.append(label)
                
            case .text(let text):
                label.text = text
                subviews.append(label)
                
            case .attributedText(let attributedText):
                label.attributedText = attributedText
                subviews.append(label)
            }
        }
        
        func handleImageStyle(_ imageStyle: EmptyResult.ImageStyle) {
            switch imageStyle {
            case .none: break
                
            case .default:
//                imageView.image = R.image.ic_baseline_close()
                subviews.append(imageView)
                
            case .noOrder:
//                imageView.image = R.image.empty_noOrder()
                subviews.append(imageView)
                
            case .noSearchResult:
//                imageView.image = R.image.empty_noSearchResult()
                subviews.append(imageView)
                
            case .loadFailed:
//                imageView.image = R.image.empty_loadFailed()
                subviews.append(imageView)
                
            case .networkUnavailable:
//                imageView.image = R.image.empty_noNetwork()
                subviews.append(imageView)
            }
        }
        
        func handleRetryStyle(_ retryStyle: EmptyResult.RetryStyle) {
            switch retryStyle {
            case .none: break
            
            case .default:
                subviews.append(retryButton)
            }
        }
        
        switch result {
        case .showEmpty(let textStyle, let imageStyle):
            handleTextStyle(textStyle, isFailed: false)
            handleImageStyle(imageStyle)
            
        case .showFailed(let textStyle, let imageStyle, let retryStyle):
            handleTextStyle(textStyle, isFailed: true)
            handleImageStyle(imageStyle)
            handleRetryStyle(retryStyle)
            
        default: break
        }
        
        if superview != containerView {
            containerView.addSubview(self)
            self.snp.makeConstraints {
                $0.center.size.equalTo(containerView)
            }
        } else {
            containerView.bringSubviewToFront(self)
        }
        
        let stackView = UIView(frame: .zero)
        subviews.forEach { stackView.addSubview($0) }
        
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(offsetY)
            $0.left.right.equalToSuperview()
        }
        
        contentView = stackView
        
        if imageView.superview != nil {
            imageView.snp.makeConstraints {
                $0.top.centerX.equalToSuperview()
                $0.size.equalTo(imageView.frame.size)
                if label.superview == nil && retryButton.superview == nil {
                    $0.bottom.equalToSuperview()
                }
            }
        }
        
        if label.superview != nil {
            label.snp.makeConstraints {
                $0.left.equalTo(20)
                $0.right.equalTo(-20)
                if imageView.superview == nil {
                    $0.top.equalToSuperview()
                } else {
                    $0.top.equalTo(imageView.snp.bottom).offset(14)
                }
                if retryButton.superview == nil {
                    $0.bottom.equalToSuperview()
                }
            }
        }
        
        if retryButton.superview != nil {
            retryButton.snp.makeConstraints {
                if (imageView.superview == nil && label.superview == nil) {
                    $0.top.equalToSuperview()
                } else if label.superview != nil {
                    $0.top.equalTo(label.snp.bottom).offset(34)
                } else {
                    $0.top.equalTo(imageView.snp.bottom).offset(34)
                }
                $0.size.equalTo(retryButton.frame.size)
                $0.centerX.bottom.equalToSuperview()
            }
        }
    }
    
    /// 手动触发重试事件
    func triggerRetry() {
        retryButton.sendActions(for: .touchUpInside)
    }
    
    /// 设置空视图的纵坐标偏移量
    var offsetY: CGFloat = -64 {
        didSet {
            contentView?.snp.updateConstraints {
                $0.centerY.equalToSuperview().offset(offsetY)
            }
            contentView?.superview?.layoutIfNeeded()
        }
    }
    
    var retryTap: Signal<Void> {
        return retryButton.rx.tap.asSignal()
    }
    
    var viewTap: Signal<EmptyResult> {
        return tapGesture.rx.event.asSignal().compactMap { [weak self] _ in self?.currentResult }
    }
}

private var EmptyResultKey: UInt8 = 0

extension UIView {
    
    /// 返回view关联的空页面视图
    var emptyResultView: EmptyResultView {
        set {
            objc_setAssociatedObject(self, &EmptyResultKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if objc_getAssociatedObject(self, &EmptyResultKey) == nil {
                let view = EmptyResultView(containerView: self)
                objc_setAssociatedObject(self, &EmptyResultKey, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return view
            }
            return objc_getAssociatedObject(self, &EmptyResultKey) as! EmptyResultView
        }
    }
}

extension Reactive where Base: UIView {
    var emptyResult: Binder<EmptyResult> {
        return Binder(base) { (view, result) in
            view.emptyResultView.setResult(result)
        }
    }
    
    var emptyResultRetryTap: Signal<Void> {
        return base.emptyResultView.retryTap
            .do(onNext: { [weak base] in
                base?.emptyResultView.removeFromSuperview()
            })
    }
    
    var emptyResultViewTap: Signal<EmptyResult> {
        return base.emptyResultView.viewTap
    }
}

