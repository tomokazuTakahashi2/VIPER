//
//  Interactor.swift
//  VIPER
//
//  Created by 高橋智一 on 2021/05/08.
//

import Foundation

//object
//protcol
//ref to presenter

//https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            do{
                let entities = try JSONDecoder().decode([User].self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            }
            catch{
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()

    }
}
