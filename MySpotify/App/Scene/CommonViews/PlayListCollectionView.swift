//
//  PlayListCollectionView.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 11/04/2022.
//

import Foundation
import UIKit

final class PlayListCollectionView: UICollectionView {
    private var playList: [PlayListWidget] = []
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not be implemented")
    }
    
    private func initialize() {
        dataSource = self
        delegate = self
        self.register(PlayListCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PlayListCollectionViewCell.self))
    }
    
    func setPlayList(_ playList: [PlayListWidget]) {
        self.playList = playList
        self.reloadData()
    }
}

extension PlayListCollectionView: UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlayListCollectionViewCell.self), for: indexPath) as! PlayListCollectionViewCell
        cell.setPlayList(self.playList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
