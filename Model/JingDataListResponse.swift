//
//  JingDataListResponse.swift
//  Alamofire
//
//  Created by Tian on 2018/9/3.
//

import Foundation

public protocol JingDataListResoponse {
    var list: [JingDataListData]? { set get }
}

public protocol JingDataListData {
    var index: Int? { set get }
}

public enum JingDataListPosition {
    
    case id(Int?)
    case page(Int)
    
    var value: Int? {
        switch self {
        case .id(let id):
            return id
        case .page(let page):
            return page
        }
    }
    
    mutating func reset() {
        switch self {
        case .id:
            self = .id(nil)
        case .page:
            self = .page(1)
        }
    }
    
    mutating func next(index: Int?) {
        switch self {
        case .id:
            self = .id(index)
        case .page(let page):
            self = .page(page + 1)
        }
    }
}
