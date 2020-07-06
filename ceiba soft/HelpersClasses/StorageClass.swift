//
//  StorageClass.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 2/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import Foundation

open class Storage {


    static func loadUserFromLocal( completion: @escaping (_ result: Result<[UserModel], Error>) -> Void ) {
        
        guard let userDataRaw = UserDefaults.standard.data(forKey: CUSTOM_KEY_STORAGE_USERS ) else {
            return completion( .failure( CustomError.build(errorString: .not_users) ) )
        }
        
        do{
            let userData = try JSONDecoder().decode([UserModel].self, from: userDataRaw )
            completion( .success(userData) )
        } catch {
            completion( .failure( CustomError.build(errorString: .storage_user_data) ))
        }
    }
    
    static func saveUsersDataInLocal(userData: Data?){
        UserDefaults.standard.set(userData, forKey: CUSTOM_KEY_STORAGE_USERS)
    }
}
