//
//  ViewController.swift
//  v1
//
//  Created by 方奎元 on 2023/10/27.
//

import UIKit

class TabViewController: UIViewController {
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var accountBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var serviceBtn: UIButton!
    @IBOutlet weak var tabView: UIView!
    
    var selectedIndex = 4
    var previousIndex = 4
    var viewControllers = [UIViewController]()
    var messagesVM: [MessageViewModel]?
    
    static let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC")
    static let accountVC = AccountVC()
    static let locationVC = LocationVC()
    static let serviceVC = ServiceVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupControllers()
        self.setupTabView()
        self.setupBtn()
        guard let btn = self.view.viewWithTag(selectedIndex) as? UIButton else {
            fatalError("Can not find button")
        }
        
        self.tabChanged(btn)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getNotify), name: .getMessages, object: nil)
    }
    
    @objc func getNotify(notification: Notification) {
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "bellActive"), style: .plain, target: self, action: #selector(bellPressed)), animated: true)
        guard let vms = notification.userInfo?["vm"] as? [MessageViewModel] else {return}
        self.messagesVM = vms
        
    }


    @IBAction func tabChanged(_ sender: UIButton) {
        self.view.viewWithTag(selectedIndex)?.tintColor = UIColor(named: "unselectedColor")
        sender.tintColor = UIColor(named: "selectedColor")
        previousIndex = selectedIndex
        selectedIndex = sender.tag
        
        let previousVC = viewControllers[previousIndex == 4 ? 0 : previousIndex]

        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()


        let vc = viewControllers[selectedIndex == 4 ? 0 : selectedIndex]
        //vc.view.frame = UIApplication.shared.windows[0].frame
        vc.didMove(toParent: self)
        self.addChild(vc)
        self.view.addSubview(vc.view)

        self.view.bringSubviewToFront(tabView)

    }
    
    private func setupControllers() {
        self.viewControllers.append(TabViewController.homeVC)
        self.viewControllers.append(TabViewController.accountVC)
        self.viewControllers.append(TabViewController.locationVC)
        self.viewControllers.append(TabViewController.serviceVC)
    }
    
    private func setupTabView() {
        self.tabView.layer.cornerRadius = 25
        self.tabView.layer.shadowColor = UIColor.darkGray.cgColor
        self.tabView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.tabView.layer.shadowOpacity = 0.3
        self.tabView.layer.opacity = 1.0
        self.tabView.layer.isHidden = false
        self.tabView.layer.masksToBounds = false
        self.tabView.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "bellNormal"), style: .plain, target: self, action: #selector(bellPressed))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "avatar"), style: .plain, target: nil, action: nil)
        self.view.backgroundColor = UIColor(named: "background")
    }
    
    private func setupBtn() {
        self.homeBtn.verticalSet(title: "Home", imageName: "home")
        self.accountBtn.verticalSet(title: "Account", imageName: "account")
        self.locationBtn.verticalSet(title: "Location", imageName: "location")
        self.serviceBtn.verticalSet(title: "Service", imageName: "service")
        
    }
    
    @objc private func bellPressed() {
        performSegue(withIdentifier: "toMessage", sender: self.messagesVM)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MessageTableVC,
           let vms = sender as? [MessageViewModel] {
            vc.messageListVM.messagesViewModel = vms
        }
    }
    
}

