//
//  MyInfoWidget.swift
//  MySpotify
//
//  Created by Ngoc Vũ on 04/04/2022.
//

import Foundation

struct MyInfoWidget {
    let userName: String
    let avatarSource: URL?
    let follower: NSAttributedString
    
    static func transform(from user: User) -> MyInfoWidget {
        let avatarURL = URL(string: user.images.first?.url ?? "")
        let totalFolow = user.follower.total
        let follower = NSAttributedString(string: "Has \(totalFolow) \(totalFolow > 1 ? "followers" : "follower")")
        return MyInfoWidget(userName: user.displayName,
                                      avatarSource: avatarURL,
                                      follower: follower)
    }
}

extension MyInfoWidget: Equatable {
    static func == (lhs: MyInfoWidget, rhs: MyInfoWidget) -> Bool {
        return lhs.userName == rhs.userName && lhs.avatarSource == rhs.avatarSource && lhs.follower == rhs.follower
    }
}

extension MyInfoWidget {
    static var unknownWidget: MyInfoWidget = MyInfoWidget(userName: "Unknown",
                                                          avatarSource: nil,
                                                          follower: NSAttributedString(string: "none follower"))
}
