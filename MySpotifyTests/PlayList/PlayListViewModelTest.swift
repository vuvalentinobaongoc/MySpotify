//
//  PlayListViewModelTest.swift
//  MySpotifyTests
//
//  Created by Ngoc Vũ on 11/04/2022.
//

import Foundation
import Nimble
import Quick
import RxNimble
import RxSwift
import RxTest
@testable import MySpotify

final class PlayListViewModelTest: QuickSpec {
    override func spec() {
        describe("Transform input to output") {
            let initialClock = 0
            let userUseCase: UserUseCase = MyUserUseCase(repository: UnhappyMockUserRepository())
            let playListUseCase: PlayListUseCase = MyPlayListUseCase(repository: UnhappyMockPlayListRepository())
            let homeViewModel: HomeViewModel = HomeViewModel(userUseCase: userUseCase,
                                                             playListUseCase: playListUseCase)
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: initialClock, simulateProcessingDelay: false)
            }
            context("when network failed") {
                it("with arbinary input should return expected output") {
                    // Expectations
                    let expectedInfoEvents =  Recorded<Event<MyInfoWidget>>.events(.next(0,.unknownWidget))
                    let expectedPlaylistEvents = Recorded<Event<[PlayListWidget]>>.events(.next(0, []), .completed(0))
                    
                    // Input
                    let viewDidLoad: TestableObservable<Void> = scheduler.createHotObservable([
                        .next(0, ()),
                    ])
                    let userAuthorized: TestableObservable<Void> = scheduler.createHotObservable([
                        .next(0, ()),
                    ])

                    // Binding object
                    let myInfoOutput = scheduler.createObserver(MyInfoWidget.self)
                    let playListOutput = scheduler.createObserver([PlayListWidget].self)
                    
                    let input = HomeViewModel.Input(viewDidload: viewDidLoad.asDriver(onErrorJustReturn: ()),
                                                    userAuthorized: userAuthorized.asObservable())
                    // Output
                    let output = homeViewModel.transform(input: input)
                    output.myInfo.drive(myInfoOutput).disposed(by: disposeBag)
                    output.playList.drive(playListOutput).disposed(by: disposeBag)
                    
                    scheduler.start()
                    
                    // Asertion
                    XCTAssertEqual(myInfoOutput.events, expectedInfoEvents)
                    XCTAssertEqual(playListOutput.events, expectedPlaylistEvents)
                }
            }
        }
        
        describe("Transform input to output") {
            let initialClock = 0
            let userUseCase: UserUseCase = MyUserUseCase(repository: MockUserRepository())
            let playListUseCase: PlayListUseCase = MyPlayListUseCase(repository: MockPlayListRepository())
            let homeViewModel: HomeViewModel = HomeViewModel(userUseCase: userUseCase,
                                                             playListUseCase: playListUseCase)
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: initialClock, simulateProcessingDelay: false)
            }
            context("when network success") {
                it("with arbinary input should return expected output") {
                    // Expectations
                    let expectedInfoWidget = MyInfoWidget.transform(from: User.dummyUser)
                    let expectedInfoEvents =  Recorded<Event<MyInfoWidget>>.events(.next(0, expectedInfoWidget))
                    let expectedPlaylistEvents = Recorded<Event<[PlayListWidget]>>
                        .events(
                            .next(0, PlayLists
                                    .dummyPlayLists
                                    .items
                                    .map { PlayListWidget(name: $0.name, id: $0.id) }
                                 )
                        )
                    
                    // Input
                    let viewDidLoad: TestableObservable<Void> = scheduler.createHotObservable([
                        .next(0, ()),
                    ])
                    let userAuthorized: TestableObservable<Void> = scheduler.createHotObservable([
                        .next(0, ()),
                    ])

                    // Binding object
                    let myInfoOutput = scheduler.createObserver(MyInfoWidget.self)
                    let playListOutput = scheduler.createObserver([PlayListWidget].self)
                    
                    let input = HomeViewModel.Input(viewDidload: viewDidLoad.asDriver(onErrorJustReturn: ()),
                                                    userAuthorized: userAuthorized.asObservable())
                    // Output
                    let output = homeViewModel.transform(input: input)
                    output.myInfo.drive(myInfoOutput).disposed(by: disposeBag)
                    output.playList.drive(playListOutput).disposed(by: disposeBag)
                    
                    scheduler.start()
                    
                    // Asertion
                    XCTAssertEqual(myInfoOutput.events, expectedInfoEvents)
                    XCTAssertEqual(playListOutput.events, expectedPlaylistEvents)
                }
            }
        }
    }
}
    
