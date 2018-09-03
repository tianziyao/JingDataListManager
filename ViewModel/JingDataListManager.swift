//
//  JingDataListManager.swift
//  Alamofire
//
//  Created by Tian on 2018/9/3.
//

import Foundation
import JingDataNetwork
import RxCocoa
import RxSwift
import Moya

public enum JingDataListManagerError: Error {
    case isRequesting
    case listEmpty
}

public protocol JingDataListManager: class {
    
    associatedtype T: TargetType
    associatedtype C: JingDataNetworkConfig
    associatedtype R: JingDataListResoponse
    
    weak var listController: JingDataRefreshListController? { set get }

    var position: JingDataListPosition { set get }
    var api: T { set get }
    var isFree: Bool { set get }
    var list: [JingDataListData] { set get }
    var bag: DisposeBag { get }
    
    init(position: JingDataListPosition, listController: JingDataRefreshListController, api: T)
}

public extension JingDataListManager {
    
    public var numberOfRowsInList: Int {
        return list.count
    }
    
    public func data<D: JingDataListData>(atRow row: Int) -> D? {
        guard row < numberOfRowsInList else { return nil }
        return list[row] as? D
    }
    
    public init(position: JingDataListPosition, listController: JingDataRefreshListController, api: T) {
        self.init(position: position, listController: listController, api: api)
        self.position = position
        self.listController = listController
        self.api = api
        self.isFree = true
    }
    
    public func refreshObserver() -> Observable<R> {
        let ob = Observable.create { (ob: AnyObserver<R>) -> Disposable in
            self.position.reset()
            self.loadData()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] (resp) in
                    guard let `self` = self else { return }
                    self.listController?.tableView.endRefresh()
                    self.listController?.tableView.resetNoMoreData()
                    guard let list = resp.list, list.count != 0 else {
                        self.listController?.state = .empty
                        ob.onError(JingDataListManagerError.listEmpty)
                        return
                    }
                    self.list = list
                    self.listController?.state = .success
                    self.listController?.reloadData()
                    self.position.next(index: list.last?.index)
                    ob.onNext(resp)
                    }, onError: { [weak self] (error) in
                        self?.listController?.tableView.endRefresh()
                        self?.listController?.tableView.resetNoMoreData()
                        self?.listController?.state = .fail
                        self?.list.removeAll()
                        self?.listController?.reloadData()
                        ob.onError(error)
                })
                .disposed(by: self.bag)
            return Disposables.create()
        }
        return ob
    }
    
    public func loadMoreObserver() -> Observable<R> {
        let ob = Observable.create { (ob: AnyObserver<R>) -> Disposable in
            self.position.reset()
            self.loadData()
                .observeOn(MainScheduler.instance)
                .subscribe(onNext: { [weak self] (resp) in
                    guard let `self` = self else { return }
                    let tmp = (resp.list ?? [])
                    self.list += tmp
                    self.listController?.reloadData()
                    self.position.next(index: tmp.last?.index)
                    if tmp.count == 0 {
                        self.listController?.noMoreData()
                    }
                    else {
                        self.listController?.endLoadData()
                    }
                    ob.onNext(resp)
                    }, onError: { [weak self] (error) in
                        self?.listController?.state = .fail
                        self?.list.removeAll()
                        self?.listController?.reloadData()
                        ob.onError(error)
                })
                .disposed(by: self.bag)
            return Disposables.create()
        }
        return ob
    }
    
    public func loadData() -> Observable<R> {
        let ob = Observable.create { (ob: AnyObserver<R>) -> Disposable in
            guard self.isFree else {
                ob.onError(JingDataListManagerError.isRequesting)
                return Disposables.create()
            }
            JingDataNetworkManager<T, C>.base(api: self.api)
                .observer()
                .subscribe(onNext: { (resp: R) in
                    ob.onNext(resp)
                }, onError: { (error) in
                    ob.onError(error)
                })
                .disposed(by: self.bag)
            return Disposables.create()
        }
        return ob
    }
}
