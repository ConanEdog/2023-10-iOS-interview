//
//  MessageResponse.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import Foundation

struct MessageResponse: Codable{
    let msgCode: String
    let msgContent: String
    let result: MessageList
}

struct MessageList: Codable {
    let messages: [Message]?
}

struct Message: Codable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}

extension Message {
    static func getMessage() -> Resource<MessageResponse> {
        guard let url = URL(string: "https://willywu0201.github.io/data/notificationList.json") else {
            fatalError("URL is incorrect.")
        }
        return Resource<MessageResponse>(url: url)
    }
}
