//
//  JingDataListView.swift
//  Alamofire
//
//  Created by Tian on 2018/9/3.
//

import Foundation
import JingDataStateSwitch
import JingDataNetwork
import Moya

public typealias JingDataRefreshListController = JingDataRefreshListControllerManager & JingDataStateSwitch & UIViewController

@objc public protocol JingDataRefreshListControllerManager {
    var tableView: JingDataRefreshListView { get }
    @objc optional func reloadData()
    @objc optional func noMoreData()
    @objc optional func endLoadData()
}

public extension JingDataRefreshListControllerManager {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func noMoreData() {
        tableView.endLoadMore(hasMore: false)
    }
    
    func endLoadData() {
        tableView.endLoadMore(hasMore: true)
    }
}



