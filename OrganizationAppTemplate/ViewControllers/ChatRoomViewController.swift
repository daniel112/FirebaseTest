//
//  ChatRoomViewController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/3/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import IGListKit

class ChatRoomViewController: BaseViewController {

    // MARK: - Properties
    var listObjects:Array = [ListDiffable]()
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        view.backgroundColor = UIColor.white
        view.alwaysBounceVertical = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.createChatRoomObjects()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private API
    private func setup() {
        
        // title
        self.title = "Channels"
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30)]
        
        // Navigation button add
        let buttonAdd = UIBarButtonItem.init(image: UIImage.init(named: "nav_add"), style: .plain, target: self, action: #selector(buttonAdd_TouchUpInside(_:)))
        self.navigationItem.rightBarButtonItem = buttonAdd
        
        //collectionView
        view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        //adapter
        self.adapter.collectionView = self.collectionView
        self.adapter.dataSource = self
    }
    
    private func createChatRoomObjects() {
        var array = [Channel]()
        array.append(Channel.init(withID: "01", name: "Room 1", creator: "Daniel", members: 1, isPrivate: false))
        array.append(Channel.init(withID: "02", name: "Room 2", creator: "Daniel", members: 1, isPrivate: false))

        self.listObjects.append(IGListDiffableArray.init(withArray: array))
        self.adapter.performUpdates(animated: true, completion: nil)

    }
    
    // MARK: UIResponder
    @objc private func buttonAdd_TouchUpInside(_ sender:UIBarButtonItem!) {
        self.navigationController?.present(ChatRoomAddViewController(), animated: true)
    }

    
}

extension ChatRoomViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return self.listObjects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        
        let controller = LabelSubLabelSectionController()
        controller.delegate = self
        return controller
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.text = "No room available"
        label.textAlignment = .center
        return label
    }
}

extension ChatRoomViewController: LabelSubLabelSectionControllerDelegate {
    func didSelectOptionItem(item: Any) {
        if (item is Channel) {

            self.navigationController?.pushViewController(ChatViewController.init(user: App.shared.currentUser, channel: item as! Channel), animated: true)
        }
    }
    
    
}


