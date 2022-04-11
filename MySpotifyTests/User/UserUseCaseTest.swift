//
//  UserUseCaseTest.swift
//  MySpotifyTests
//
//  Created by Ngoc Vũ on 07/04/2022.
//

import Foundation
import Nimble
import Quick
import RxNimble
import RxSwift
import RxTest
@testable import MySpotify

final class UserUseCaseSpecs: QuickSpec {
    override func spec() {
        describe("User with unhappy case") {
            let initialClock = 0
            let userUseCase: UserUseCase = MyUserUseCase(repository: UnhappyMockUserRepository())
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: initialClock, simulateProcessingDelay: false)
            }
            context("when user open app") {
                it("should retrieve unknown widget if get token or user failed") {
                    let expectUser = MyInfoWidget.unknownWidget
                    let expectedEvents = Recorded.events(.next(0, expectUser),.completed(0))
                    expect(userUseCase.getMyInfomation())
                        .events(scheduler: scheduler, disposeBag: disposeBag) == expectedEvents
                }
            }
        }
        
        describe("User with happy case") {
            let initialClock = 0
            let userUseCase: UserUseCase = MyUserUseCase(repository: MockUserRepository())
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: initialClock, simulateProcessingDelay: false)
            }
            context("when user open app") {
                it("should return infomation widget correspondence with arbinary user info") {
                    let expectedWidget = MyInfoWidget.transform(from: User.dummyUser)
                    let expectedEvents = Recorded.events(.next(0, expectedWidget),.completed(0))
                    expect(userUseCase.getMyInfomation())
                        .events(scheduler: scheduler, disposeBag: disposeBag) == expectedEvents
                }
                
                it("widget should not match with unexpected user") {
                    let unexpectedUser = User.anotherDummyUser
                    let expectedWidget = MyInfoWidget.transform(from: unexpectedUser)
                    let expectedEvents = Recorded.events(.next(0, expectedWidget),.completed(0))
                    expect(userUseCase.getMyInfomation())
                        .events(scheduler: scheduler, disposeBag: disposeBag) != expectedEvents
                }
            }
        }
    }
}
