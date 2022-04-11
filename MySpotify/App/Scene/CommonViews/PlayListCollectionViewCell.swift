//
//  PlayListCollectionViewCell.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 11/04/2022.
//

import Foundation
import UIKit

class PlayListCollectionViewCell: UICollectionViewCell {
    private lazy var _nameLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        lb.textColor = UIColor.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var _playButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "ic_play"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not be implemented")
    }
    
    private func initialize() {
        self.contentView.addSubview(_playButton)
        self.contentView.addSubview(_nameLabel)
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.cornerRadius = 4
        NSLayoutConstraint.activate([
            _playButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            _playButton.widthAnchor.constraint(equalToConstant: 24),
            _playButton.heightAnchor.constraint(equalToConstant: 24),
            _playButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            _nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            _nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            _nameLabel.trailingAnchor.constraint(equalTo: self._playButton.leadingAnchor, constant: -20)
        ])
    }
    
    func setPlayList(_ playList: PlayListWidget) {
        self._nameLabel.text = playList.name
    }
}
