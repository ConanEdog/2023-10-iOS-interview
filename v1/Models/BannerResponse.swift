//
//  AdResponse.swift
//  v1
//
//  Created by 方奎元 on 2023/10/29.
//

import Foundation

struct BannerResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: BannerList
}

struct BannerList: Codable {
    let bannerList: [Banner]
}

struct Banner: Codable {
    let adSeqNo: Int
    let linkUrl: String
}

extension Banner {
    static func getBanner() -> Resource<BannerResponse> {
        guard let url = URL(string: "https://willywu0201.github.io/data/banner.json") else {
            fatalError("URL is incorrect.")
        }
        return Resource<BannerResponse>(url: url)
    }
}
