//
//  HomeVC.swift
//  v1
//
//  Created by 方奎元 on 2023/10/27.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate {

    private var accountListVM = AccountListViewModel()
    private var messageListVM = MessageListViewModel()
    private var favoriteListVM = FavoriteListViewModel()
    private var bannerListVM = BannerListViewModel()
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: HomeScrowView!
    @IBOutlet weak var bannerScrollView: BannerScrollView!
    @IBOutlet weak var btnCollectionView: UICollectionView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    private var adTimer: Timer?
    private var direction: ScrollDirection = .right
    private var index = 1
    private var lastTimeOffSetX: CGFloat?
    
    var eyeBtn: UIButton!
    var refreshControl: UIRefreshControl!
    var isHide: Bool = false
    private var usdBalance: Double = 0 {
        didSet {
            self.updateNum()
        }
    }
    private var khrBalance: Double = 0 {
        didSet {
            self.updateNum()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        self.configRefreshControl()
        self.scrollView.setup()
        self.setupEyeBtn()
        self.btnCollectionLayout()
        self.favoriteCollectionViewLayOut()
        self.setupBanner()
        //scrollView.backgroundColor = .gray
        self.view.backgroundColor = UIColor(named: "background")
        
        Task {
            await self.updateAmount(new: false)
            try? await self.bannerListVM.loadBanners()
            self.bannerScrollView.imageURLs = self.bannerListVM.getURLs()
            self.configPageControl()
            startTimer()
            self.scrollView.contentSize = CGSize(width: self.scrollView.bounds.width, height: self.pageControl.frame.maxY + 80)
            print(bannerScrollView.contentSize)
            print(bannerScrollView.bounds.width)
        }
        
    }

    
    private func setupEyeBtn() {
        eyeBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        eyeBtn.setImage(UIImage(named: "eyeOn"), for: .normal)
        eyeBtn.addTarget(self, action: #selector(eyeBtnPressed), for: .touchUpInside)
        self.view.addSubview(eyeBtn)
        eyeBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eyeBtn.leftAnchor.constraint(equalTo: scrollView.titleLabel.rightAnchor, constant: 8),
            eyeBtn.topAnchor.constraint(equalTo: scrollView.titleView.topAnchor, constant: 12)
            
        ])
    }
    
    @objc private func eyeBtnPressed(_ sender: UIButton) {
        if !isHide {
            //Off
            isHide = true
            sender.setImage(UIImage(named: "eyeOff"), for: .normal)
            self.updateNum()
        } else {
            //On
            isHide = false
            sender.setImage(UIImage(named: "eyeOn"), for: .normal)
            self.updateNum()
        }
    }
    
    private func getBalance(currency: CurrencyType) -> Double {
        let balance = self.accountListVM.getTotalBalance(currency: currency)
        return balance
    }
    
    private func updateAmount(new: Bool) async {
        try? await self.accountListVM.getAccountVM(new)
        usdBalance = self.getBalance(currency: .USD)
        khrBalance = self.getBalance(currency: .KHR)
        
    }
    
    private func updateNum() {
        if isHide {
            scrollView.usdLabel?.text = usdBalance.toCurrencyString().hide()
            scrollView.khrLabel?.text = khrBalance.toCurrencyString().hide()
        } else {
            scrollView.usdLabel?.text = usdBalance.toCurrencyString()
            scrollView.khrLabel?.text = khrBalance.toCurrencyString()
        }
    }
    
    
    private func configRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.scrollView.refreshControl = refreshControl
    }
    
    @objc private func refresh() {
        Task {
            await self.updateAmount(new: true)
            try? await self.messageListVM.loadMessage()
            try? await self.favoriteListVM.loadFavoriteItems()
            
            self.favoriteCollectionView.reloadData()
            print("Refreshing")
            refreshControl.endRefreshing()
        }
    }
    
    
    
}

//MARK: - CollectionView
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionView == btnCollectionView ? 6 : self.favoriteListVM.numberOfItem()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == btnCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "btnCell", for: indexPath) as! BtnCollectionViewCell
            cell.configure(index: indexPath.item)
            
            return cell
            
        } else {
            self.favoriteCollectionView.restoreBackgroundView()
            let vm = self.favoriteListVM.favoriteViewModel(at: indexPath.item)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCell", for: indexPath) as! FavoriteCollectionViewCell
            cell.configure(vm: vm)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = self.favoriteCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderView
        headerView.configure()
        return headerView
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func generateLayout2() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(2/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .continuous
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func btnCollectionLayout() {
        self.btnCollectionView.backgroundColor = UIColor(named: "background")
        self.btnCollectionView.delegate = self
        self.btnCollectionView.dataSource = self
        self.btnCollectionView.allowsSelection = true
        self.btnCollectionView.collectionViewLayout = self.generateLayout()
        self.btnCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.btnCollectionView.topAnchor.constraint(equalTo: self.scrollView.khrLabel.bottomAnchor, constant: 4),
            self.btnCollectionView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor),
            self.btnCollectionView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor)
            
        ])
    }
    
    func favoriteCollectionViewLayOut() {
        self.favoriteCollectionView.setEmptyMessage("You can add a favorite through the transfer or payment function.")
        self.favoriteCollectionView.delegate = self
        self.favoriteCollectionView.dataSource = self
        self.favoriteCollectionView.allowsSelection = true
        self.favoriteCollectionView.collectionViewLayout = self.generateLayout2()
        self.favoriteCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.favoriteCollectionView.topAnchor.constraint(equalTo: self.btnCollectionView.bottomAnchor, constant: 8),
            self.favoriteCollectionView.rightAnchor.constraint(equalTo: self.scrollView.rightAnchor),
            self.favoriteCollectionView.leftAnchor.constraint(equalTo: self.scrollView.leftAnchor)
        ])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select at \(indexPath.item)")
    }
    
    
}


//MARK: - banner
extension HomeVC: UIScrollViewDelegate {
    
    func setupBanner() {
        self.bannerScrollView.delegate = self
        self.bannerScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.bannerScrollView.topAnchor.constraint(equalTo: self.favoriteCollectionView.bottomAnchor, constant: 4),
            self.bannerScrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.bannerScrollView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 48),
            self.bannerScrollView.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
    
    func configPageControl() {
        self.pageControl.pageIndicatorTintColor = .lightGray
        self.pageControl.currentPageIndicatorTintColor = .black
        self.pageControl.numberOfPages = self.bannerScrollView.imageURLs.count
        self.pageControl.currentPage = 0
        self.pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
    }
    
    @objc func pageChanged() {
        let contentOffSetMinX = self.bannerScrollView.bounds.width * CGFloat(pageControl.currentPage + 1)
        let point = CGPoint(x: contentOffSetMinX, y: 0)
        self.bannerScrollView.setContentOffset(point, animated: true)
        index = Int(contentOffSetMinX / self.bannerScrollView.frame.width)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.bannerScrollView {
            let offSetX = self.bannerScrollView.contentOffset.x
            //first(fake 0 real 4) move to the real last(fake 5 real 4)
            if offSetX == 0 {
                let contentOffsetMinX = self.bannerScrollView.bounds.width * CGFloat(self.bannerScrollView.imageURLs.count)
                self.bannerScrollView.contentOffset = CGPoint(x: contentOffsetMinX, y: 0)
                lastTimeOffSetX = contentOffsetMinX
            }
            //last(fake 6 real 0) move to real first(fake 1 real 0)
            if offSetX == self.bannerScrollView.bounds.width * CGFloat(self.bannerScrollView.imageURLs.count + 1) {
                self.bannerScrollView.contentOffset = CGPoint(x: self.bannerScrollView.frame.width, y: 0)
                lastTimeOffSetX = self.bannerScrollView.bounds.width
            }
            
            let page = round(self.bannerScrollView.contentOffset.x / self.bannerScrollView.bounds.width) - 1
            pageControl.currentPage = Int(page)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        guard let lastTimeOffSetX = lastTimeOffSetX else {return}
//        let currentOffsetX = self.bannerScrollView.contentOffset.x
//
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffSetMinX = self.bannerScrollView.contentOffset.x
        
        index = Int(contentOffSetMinX / self.bannerScrollView.frame.width)
        print(index)
        lastTimeOffSetX = self.bannerScrollView.contentOffset.x
        
        startTimer()
    }
    
    func startTimer() {
        if adTimer != nil {
            adTimer?.invalidate()
        }
        adTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        adTimer?.invalidate()
        adTimer = nil
    }
    
    @objc func autoScroll() {
        switch direction{
        case .right:
            if index == self.bannerScrollView.imageURLs.count + 1 {
                index = 2
            }else {
                index += 1
            }
        case .left:
            if index == 0 {
                index = self.bannerScrollView.imageURLs.count - 1
            } else {
                index -= 1
            }
        }
        
        self.bannerScrollView.setContentOffset(CGPoint(x: self.bannerScrollView.bounds.width * CGFloat(index), y: 0), animated: true)
        lastTimeOffSetX = self.bannerScrollView.bounds.width * CGFloat(index)
    }
}


