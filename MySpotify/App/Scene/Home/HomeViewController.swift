//
//  HomeViewController.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 04/04/2022.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

final class HomeViewController: UIViewController {
    
    private let bag = DisposeBag()
    
    // MARK: - Dependency
    private var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not be implemented")
    }
    
    // MARK: - Views
    
    private lazy var _nameLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 2
        lb.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        lb.textColor = UIColor.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var _followerLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        lb.textColor = UIColor.darkGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var _playListLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        lb.textColor = UIColor.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "My Playlists"
        return lb
    }()
    
    private lazy var _startButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.black
        btn.setTitle("Play", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        btn.setTitleColor(.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var _avatarImageView: UIImageView = {
        let imgv = UIImageView()
        imgv.contentMode = .scaleAspectFill
        imgv.backgroundColor = UIColor.black
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.clipsToBounds = true
        return imgv
    }()
    
    private lazy var _playListCollectionView: PlayListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let clv = PlayListCollectionView(frame: .zero, collectionViewLayout: layout)
        clv.backgroundColor = .white
        clv.translatesAutoresizingMaskIntoConstraints = false
        return clv
    }()
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        self.setupUserInterface()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Internal calls
    
    private func bindViewModel() {
        assert(viewModel != nil)
        
        let viewDidLoad = rx.sentMessage(#selector(UIViewController.viewDidLoad)).map { _ in ()}.asDriver(onErrorJustReturn: ())
        let userAuthorize = NotificationCenter.default.rx.notification(.userAuthorized, object: nil).map { _ in ()}
        let input = HomeViewModel.Input(viewDidload: viewDidLoad, userAuthorized: userAuthorize)
        
        let output = viewModel.transform(input: input)
        
        output.myInfo.debug("My info widget", trimOutput: true).drive(onNext: {[weak self] widget in
            guard let self = self else {
                return
            }
            let processor = RoundCornerImageProcessor(cornerRadius: self._avatarImageView.frame.height / 2)
            self._nameLabel.text = widget.userName
            self._avatarImageView.kf.setImage(with: widget.avatarSource, placeholder: nil, options: [.processor(processor)])
            self._followerLabel.attributedText = widget.follower
        }).disposed(by: bag)
        
        output.playList.drive(onNext: {[weak self] playList in
            guard let self = self else {
                return
            }
            self._playListCollectionView.setPlayList(playList)
        }).disposed(by: bag)
    }
    
    private func setupUserInterface() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(_startButton)
        self.view.addSubview(_nameLabel)
        self.view.addSubview(_avatarImageView)
        self.view.addSubview(_followerLabel)
        self.view.addSubview(_playListCollectionView)
        self.view.addSubview(_playListLabel)
        
        NSLayoutConstraint.activate([
            _avatarImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            _avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            _avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            _avatarImageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            
            _nameLabel.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 12),
            _nameLabel.leadingAnchor.constraint(equalTo: self._avatarImageView.trailingAnchor, constant: 8),
            _nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            _followerLabel.leadingAnchor.constraint(equalTo: self._avatarImageView.trailingAnchor, constant: 8),
            _followerLabel.topAnchor.constraint(equalTo: self._nameLabel.bottomAnchor, constant: 4),
            _followerLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            _startButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            _startButton.heightAnchor.constraint(equalToConstant: 50),
            _startButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            _startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            _startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
           
            _playListLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            _playListLabel.topAnchor.constraint(equalTo: self._avatarImageView.bottomAnchor, constant: 20),
            
            _playListCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            _playListCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            _playListCollectionView.topAnchor.constraint(equalTo: self._playListLabel.bottomAnchor, constant: 12),
            _playListCollectionView.bottomAnchor.constraint(equalTo: self._startButton.topAnchor, constant: -16)
        ])
    }
}
