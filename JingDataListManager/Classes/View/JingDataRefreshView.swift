//
//  JingDataRefreshView.swift
//  Alamofire
//
//  Created by Tian on 2018/8/31.
//

import Foundation
import MJRefresh

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let r = CGFloat(((hex & 0xFF0000) >> 16)) / 255.0
        let g = CGFloat(((hex & 0xFF00) >> 8)) / 255.0
        let b = CGFloat(((hex & 0xFF))) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

public typealias JingDataRefreshView = JingDataRefreshManager & UIScrollView
public typealias JingDataRefreshListView = JingDataRefreshManager & UITableView

@objc public protocol JingDataRefreshManager {
    @objc optional func setup(pullToRefresh action: () -> ())
    @objc optional func setup(loadMore action: () -> ())
    @objc optional func beginRefresh()
    @objc optional func endRefresh()
    @objc optional func beginLoadMore()
    @objc optional func endLoadMore(hasMore more: Bool)
    @objc optional func resetNoMoreData()
    @objc optional func hideLoadMore()
}

public extension JingDataRefreshManager where Self: UIScrollView {
    
    public func setup(pullToRefresh action: @escaping () -> ()) {
        guard mj_header == nil else { return }
        let header = MJRefreshNormalHeader(refreshingBlock: { () -> Void in
            action()
        })
        header?.lastUpdatedTimeLabel?.isHidden = true
        header?.stateLabel?.isHidden = true
        mj_header = header
    }
    
    public func setup(loadMore action: @escaping () -> ()) {
        guard mj_footer == nil else { return }
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: { () -> Void in
            action()
        })
        footer?.isRefreshingTitleHidden = true
        footer?.setTitle("", for: .idle)
        footer?.setTitle(NSLocalizedString("全部内容加载完毕",comment: ""), for: .noMoreData)
        footer?.stateLabel?.textColor = UIColor(hex: 0x999999)
        footer?.stateLabel?.font = UIFont.systemFont(ofSize: 12)
        mj_footer = footer
    }
    
    public func beginRefresh() {
        guard mj_header != nil else { return }
        mj_header.beginRefreshing()
    }
    
    public func endRefresh() {
        guard mj_header != nil else { return }
        mj_header.endRefreshing()
    }
    
    public func beginLoadMore() {
        guard mj_footer != nil else { return }
        mj_footer.beginRefreshing()
    }
    
    public func endLoadMore(hasMore more: Bool) {
        guard mj_footer != nil else { return }
        if more {
            mj_footer.endRefreshing()
        } else {
            self.mj_footer.endRefreshingWithNoMoreData()
        }
    }
    
    public func resetNoMoreData() {
        guard mj_footer != nil else { return }
        mj_footer.resetNoMoreData()
        mj_footer.isHidden = false
    }
    
    public func hideLoadMore() {
        guard mj_footer != nil else { return }
        mj_footer.isHidden = true
    }
}

