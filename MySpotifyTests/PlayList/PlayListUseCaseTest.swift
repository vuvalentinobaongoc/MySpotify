//
//  PlayListUseCaseTest.swift
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

final class PlayListUseCaseTest: QuickSpec {
    override func spec() {
        describe("Fetch playlists unhappy cases") {
            let initialClock = 0
            let playListUseCase: PlayListUseCase = MyPlayListUseCase(repository: UnhappyMockPlayListRepository())
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: initialClock, simulateProcessingDelay: false)
            }
            context("when user already authenticated") {
                it("should retrieve error if api call failed") {
                    let expectedEvents = Recorded<Event<[PlayListWidget]>>.events(.error(0, DataError.expiredToken))
                    let response = scheduler.createObserver([PlayListWidget].self)
                    playListUseCase.getPlayList(of: User.dummyUserID).asObservable().bind(to: response).disposed(by: disposeBag)
                    let responseEvents = response.events
                    scheduler.start()
                    XCTAssertEqual(responseEvents, expectedEvents)
                }
            }
        }
        
        describe("Fetch playlists with happy cases") {
            let initialClock = 0
            let playListRepo = MockPlayListRepository()
            let playListUseCase: PlayListUseCase = MyPlayListUseCase(repository: playListRepo)
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: initialClock, simulateProcessingDelay: false)
            }
            context("when user already authenticated") {
                it("total playlist items should equal to total playlist widget") {
                    let expectedPlayListEvent = Recorded.events(.next(0, PlayLists.dummyPlayLists.count), .completed(0))
                    expect(playListUseCase.getPlayList(of:User.dummyUserID).map { $0.count })
                        .events(scheduler: scheduler, disposeBag: disposeBag) == expectedPlayListEvent
                }
                
                it("first playlist should correspondence with first widget") {
                    let expectedPlayList = PlayLists.dummyPlayLists.items.first?.id
                    
                    let expectedEvent = Recorded.events(.next(0, expectedPlayList), .completed(0))
                    expect(playListUseCase.getPlayList(of:User.dummyUserID).map({ playlists in
                        playlists.first?.id
                    })).events(scheduler: scheduler, disposeBag: disposeBag) == expectedEvent
                }
                
            }
        }
    }
}
    
