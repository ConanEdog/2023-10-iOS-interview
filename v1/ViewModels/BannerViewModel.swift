//
//  BannerViewModel.swift
//  v1
//
//  Created by 方奎元 on 2023/10/29.
//

import UIKit

class BannerListViewModel {
    var bannersViewModel: [BannerViewModel]
    
    init() {
        self.bannersViewModel = [BannerViewModel]()
    }
    
    func loadBanners() async throws {
        try await Webservice().load(resource: Banner.getBanner()) { [weak self] result in
            switch result {
            case .success(let response):
                let banners = response.result.bannerList
                for banner in banners {
                    self?.bannersViewModel.append(BannerViewModel(banner: banner))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getURLs() -> [URL] {
        var arr = [URL]()
        for vm in self.bannersViewModel {
            let url = vm.linkUrl
            arr.append(url)
        }
        return arr
    }
}

class BannerViewModel {
    let banner: Banner
    var adSeqNo: Int
    var linkUrl: URL

    
    init(banner: Banner) {
        self.banner = banner
        self.adSeqNo = banner.adSeqNo
        self.linkUrl = URL(string: banner.linkUrl)!
    }
}
