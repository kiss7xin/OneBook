//
//  UIStateEnum.swift
//  OneBook
//
//  Created by weixin on 2021/8/24.
//

import Foundation

/// HUD状态
enum HUDState {
    case show(Bool, String? = nil)
    case showInfo(String)
    case showError(String)
    case showSuccess(String)
//    case showProgress(Bool)
//    case updateProgress(Float)
}

/// 空数据结果
enum EmptyResult {
    /// 移除空数据视图
    case removed
    
    /// 显示空数据视图
    case showEmpty(textStyle: TextStyle = .default, imageStyle: ImageStyle = .default)
    
    /// 显示加载失败视图
    case showFailed(textStyle: TextStyle = .default, imageStyle: ImageStyle = .loadFailed, retryStyle: RetryStyle = .default)
}

extension EmptyResult {
    
    enum TextStyle {
        case none
        case `default`
        case text(String)
        case attributedText(NSAttributedString)
    }
    
    enum ImageStyle {
        case none
        case `default`
        case noOrder
        case noSearchResult
        case loadFailed
        case networkUnavailable
    }
    
    enum RetryStyle {
        case none
        case `default`
    }
    
    var isRemoved: Bool {
        if case .removed = self { return true }
        return false
    }
    
    var isEmpty: Bool {
        if case .showEmpty = self { return true }
        return false
    }
    
    var isFailed: Bool {
        if case .showFailed = self { return true }
        return false
    }
}

/// 刷新结果
enum RefreshResult {
    /// 结束刷新
    case endRefreshing
    /// 结束刷新，并且指定当前页数
    case endRefreshingWithPage(Int)
    /// 结束刷新，并且置为无更多数据
    case endRefreshingWithNoMoreData(_ title: String? = nil)
}

/// 开始刷新
enum BeganRefreshing {
    case headerRefreshing
    case footerRefreshing
}

