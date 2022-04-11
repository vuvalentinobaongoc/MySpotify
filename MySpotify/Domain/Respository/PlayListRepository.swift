//
//  PlayListRepository.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 05/04/2022.
//

import RxSwift

protocol PlayListRepository {
    func fetchPlayList(of userId: String) -> Observable<PlayLists>
}
