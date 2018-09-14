//
//  SideMenuViewController.swift
//  SideMenuHUB
//
//  Created by Daniel Yo on 12/17/17.
//  Copyright © 2017 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit
import SnapKit
import SWRevealViewController

class SideMenuViewController: UIViewController, ListAdapterDataSource, SideMenuOptionSectionControllerDelegate {

    //MARK: variables
    var sideMenuObjects:Array = [ListDiffable]()
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = AppTheme().mainColor()
        view.alwaysBounceVertical = true
        return view
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.createSideMenuObjects()
        self.adapter.performUpdates(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Private Methods
    private func setupView() {
        
        //collectionView
        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        //adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
        
        
    }
    
    private func createSideMenuObjects() {
        //header
        self.sideMenuObjects.append(SideMenuHeader.init(withName: "App Title", image: nil, version: "1.0.0")!)
        //options
        self.sideMenuObjects.append(SideMenuItem.init(withName: "Home", image: nil)!)
        self.sideMenuObjects.append(SideMenuItem.init(withName: "Dad Jokes", image:nil)!)
        self.sideMenuObjects.append(SideMenuItem.init(withName: "Chat Room", image:nil)!)
        self.sideMenuObjects.append(SideMenuItem.init(withName: "Logout", image:nil)!)
   
    }
    
    //MARK: Delegates
    // ListAdapterDataSource
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.sideMenuObjects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        //header
        if (object is SideMenuHeader) {
            return SideMenuHeaderSectionController.init(withRevealWidth: self.revealViewController().rearViewRevealWidth)
            
        } else {
            return SideMenuItemSectionController.init(withRevealWidth: self.revealViewController().rearViewRevealWidth, delegate:self)
        }

    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
    // SideMenuOptionSectionControllerDelegate
    func didSelectSideMenuOptionItem(item: SideMenuItem) {
        if (item.name == "Dad Jokes") {
            self.revealViewController().pushFrontViewController(UINavigationController.init(rootViewController: DadJokeViewController()), animated: true)
        } else if (item.name == "Home") {
            self.revealViewController().pushFrontViewController(UINavigationController.init(rootViewController: HomeViewController()), animated: true)
        } else if (item.name == "Logout") {
            App.shared.currentUser.logout()
            self.revealViewController().present(LoginViewController(), animated: true, completion: nil)
        } else if (item.name == "Chat Room") {
            self.revealViewController().pushFrontViewController(UINavigationController.init(rootViewController: ChatRoomViewController()), animated: true)
        }
        self.revealViewController().setFrontViewPosition(FrontViewPosition.left, animated: true)
    }
}
