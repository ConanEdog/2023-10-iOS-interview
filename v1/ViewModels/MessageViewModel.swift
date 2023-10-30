//
//  MessageViewModel.swift
//  v1
//
//  Created by 方奎元 on 2023/10/28.
//

import Foundation

class MessageListViewModel {
    var messagesViewModel: [MessageViewModel]
    
    init() {
        self.messagesViewModel = [MessageViewModel]()
    }
    func messageViewModel(at index: Int) -> MessageViewModel {
        return self.messagesViewModel[index]
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.messagesViewModel.count
    }
    
    func loadMessage() async throws{
        try await Webservice().load(resource: Message.getMessage(), completion: { [weak self] result in
            switch result {
            case .success(let response):
                
                if let messages = response.result.messages {
                    for message in messages {
                        self?.messagesViewModel.append(MessageViewModel(messageInfo: message))
                    }
                    let userinfo: [AnyHashable : Any?] = ["vm" : self?.messagesViewModel]
                    NotificationCenter.default.post(name: .getMessages, object: nil, userInfo: userinfo as [AnyHashable : Any])
                    print("post")
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
}

class MessageViewModel {
    let messageInfo: Message
    var status: Bool
    var updateDateTime: String
    var title: String
    var message: String
    
    init(messageInfo: Message) {
        self.messageInfo = messageInfo
        self.status = messageInfo.status
        self.updateDateTime = messageInfo.updateDateTime
        self.title = messageInfo.title
        self.message = messageInfo.message
    }
}
