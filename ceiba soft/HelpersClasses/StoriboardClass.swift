//
//  StoriboardClass.swift
//  ceiba soft
//
//  Created by Crhistian Vergara Gomez on 2/07/20.
//  Copyright © 2020 Crhistian Vergara Gomez. All rights reserved.
//

import UIKit

class StoryboardService {
    
    enum viewControllers: String {
        case UsersView
        case PostsView
        case ProgressIndicatorView
        
        func getStoryboard() -> String {
            self.rawValue
        }
        
        func getViewConrtollerId() -> String {
            self.rawValue + "Controller"
        }
        
        func getClass() -> UIViewController {
            switch self {
            case .UsersView:
                return UsersViewController()
            case .PostsView:
                return PostsViewController()
            case .ProgressIndicatorView:
                return PostsViewController()
            }
        }
    }
    
    static func getViewController<T:UIViewController>(_ viewController: viewControllers) -> T {
        getViewController(storyboard: viewController.getStoryboard(), vc: viewController.getViewConrtollerId(), class: viewController.getClass()) as! T
    }
    
    fileprivate static func getViewController<T>(storyboard: String, vc: String, class: T) -> T {
        let vc = UIStoryboard(name: storyboard, bundle: .main).instantiateViewController(withIdentifier: vc) as! T
        return vc
    }
}
