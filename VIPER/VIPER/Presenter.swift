//
//  Presenter.swift
//  VIPER
//
//  Created by 高橋智一 on 2021/05/08.
//

import Foundation

//object
//protcol
//ref to interactor, router, view

enum FetchError: Error{
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
}


class UserPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet{
            interactor?.getUsers()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchUsers(with result: Result<[User], Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
}
