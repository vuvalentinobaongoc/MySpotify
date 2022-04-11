//
//  HomeBuilder.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 04/04/2022.
//

import Foundation

struct HomeBuilder {
    static func buildHome() -> HomeViewController {
        let homeViewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        return homeViewController
    }
}

