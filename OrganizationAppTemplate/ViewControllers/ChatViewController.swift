//
//  ChatViewController.swift
//  OrganizationAppTemplate
//
//  Created by Daniel Yo on 9/4/18.
//  Copyright © 2018 Daniel Yo. All rights reserved.
//

import UIKit
import MessageKit
import FirebaseFirestore

class ChatViewController: MessagesViewController {

    // MARK: - Properties
    private var messages: [MockMessage] = []
    private var messageListener: ListenerRegistration?
    private let user: User
    private let channel: Channel

    private let db = Firestore.firestore()
    private var reference: CollectionReference?

    var isTyping = false
    
    // MARK: - Initialization
    private func customInit() {
        
    }
    
    
    init(user: User, channel: Channel) {
        self.user = user
        self.channel = channel
        super.init(nibName: nil, bundle: nil)
        
        self.title = channel.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupFirestore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    deinit {
        messageListener?.remove()
    }
    
    // MARK: - Private API
    private func setup() {
        
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = UIColor.white
        messageInputBar.sendButton.setTitleColor(UIColor.black, for: .normal)
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
    }
    
    private func setupFirestore() {
        //  If the channel doesn’t exist, return
        guard let id = channel.id else {
            navigationController?.popViewController(animated: true)
            return
        }
        
        // channels/id/messages/
        self.reference = db.collection(["channels", id, "messages"].joined(separator: "/"))
        
        
        // Firestore calls this snapshot listener whenever there is a change to the database.
        messageListener = reference?.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }


    }
    // MARK: Helpers
    
    private func insertNewMessage(_ message: MockMessage) {
        guard !messages.contains(message) else {
            return
        }
        
        messages.append(message)
        messages.sort()
        
        let isLatestMessage = messages.index(of: message) == (messages.count - 1)
        let shouldScrollToBottom = isLatestMessage
        
        messagesCollectionView.reloadData()
        
        if shouldScrollToBottom {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }
    
    private func handleDocumentChange(_ change: DocumentChange) {
        guard let message = MockMessage(document: change.document) else {
            return
        }
        
        switch change.type {
        case .added:
            insertNewMessage(message)
            
        default:
            break
        }
    }

    
    private func save(_ message: MockMessage) {
        self.reference?.addDocument(data: message.representation) { error in
            if let e = error {
                print("Error sending message: \(e.localizedDescription)")
                return
            }
            
            self.messagesCollectionView.scrollToBottom()
        }
    }
    
    // MARK: - Public API
    
    // MARK: - Delegates
    
    
}

// MARK: - MessagesDataSource

extension ChatViewController: MessagesDataSource {

    
    func currentSender() -> Sender {
        return Sender(id: user.token!, displayName: user.displayName!)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath,
                        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
    
    func cellTopLabelAttributedText(for message: MessageType,
                                    at indexPath: IndexPath) -> NSAttributedString? {
        
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
}

extension ChatViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let message = MockMessage(user: user, content: text)
        
        save(message)
        inputBar.inputTextView.text = ""
    }
    
}

extension ChatViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
    
}

extension ChatViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        // TODO: DANIEL
        return isFromCurrentSender(message: message) ? UIColor.blue : UIColor.green
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
}
