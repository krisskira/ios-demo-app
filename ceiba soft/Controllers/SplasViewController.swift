//
//  SplashViewController.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 2/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
       
        super.viewWillAppear(animated)
        
        Storage.loadUserFromLocal { [weak self] in
            do {
                let salvedUsers = try $0.get()
                self?.showUserView(users: salvedUsers)
            } catch {
                // TODO: Handler Error Type
                // Se debe detectar el tipo de error y determinar si
                // Es por falta de datos o es por el decode del json.
                print(error.localizedDescription)
                self?.loadUserFromServer()
            }
        }
    }
    
    fileprivate func loadUserFromServer(){
        Storage.loadUsersDataFromServer { [weak self] in
            do {
                let users = try $0.get()
                self?.showUserView(users: users)
            } catch {
                // TODO: Handler Error Type
                // Se debe detectar el tipo de error y mostrar
                // el boton de reintentar la carga de los datos
                print(error)
            }
        }
    }

    fileprivate func showUserView(users: [UserModel]){
        let usersView: UsersViewController = StoryboardService.getViewController(.UsersView)
        usersView.users = users
        weak var currentView = presentingViewController
        self.present(usersView, animated: true, completion: {
            currentView?.dismiss(animated: false)
        })
    }

}
