//
//  ViewController.swift
//  JingDataListManager
//
//  Created by tianziyao on 08/30/2018.
//  Copyright (c) 2018 tianziyao. All rights reserved.
//

import UIKit
import JingDataListManager
import Moya
import JingDataNetwork
import RxSwift
import RxCocoa

enum TestApi: TargetType {
    
    case mm

    var baseURL: URL {
        return URL.init(string: "https://blog.csdn.net/ShmilyCoder/article/details/77948797?locationNum=10&fps=1")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}

class ViewController: JingDataRefreshListController {
    
    var tableView: JingDataRefreshListView = AAAAA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultStateSwitchSetup()
        tableView.setup(pullToRefresh: {
            self.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData() {
        state = .loading
        
    }

}

class AAAAA: JingDataRefreshListView {
    

}
//
//class BBBB<T: TargetType, C: JingDataNetworkConfig, R: JingDataListResoponse>: JingDataListManager {
//    var position: JingDataListPosition!
//    var listController: JingDataListController!
//    var isFree: Bool = true
//    var api: T!
//    var list: [D] = [D]()
//    var bag: DisposeBag = DisposeBag()
//}


