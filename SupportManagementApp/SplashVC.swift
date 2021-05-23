//
//  SplashVC.swift
//  SupportManagementApp
//
//  Created by HBO on 19.05.2021.
//

import UIKit

class SplashVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    let pageControl = UIPageControl()
    let skipButton = UIButton()
    let nextButton = UIButton()
    var pageControlBottomAnchor : NSLayoutConstraint?
    var skipButtomTopAnchor : NSLayoutConstraint?
    var nextButtomTopAnchor : NSLayoutConstraint?
    
    let cellId = "cellId"
    let loginCellId = "loginCellId"
    
    let pages: [Page] = {
        let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in your life. Every recipient's first book is on us.", imageName: "page1")
        
        let secondPage = Page(title: "Send from your library", message: "Tap the More menu next to any book. Choose \"Send this Book\"", imageName: "page2")
        
        let thirdPage = Page(title: "Send from the player", message: "Tap the More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configurePageController()
        configureSkipButton()
        configureNextButton()
        registerCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int( targetContentOffset.pointee.x/view.frame.width)
        pageControl.currentPage = pageNumber
        
        if pageNumber == self.pages.count{
            moveControlConstraintsOffScreen()
        } else {
            pageControlBottomAnchor?.constant = 0
            skipButtomTopAnchor?.constant = 16
            nextButtomTopAnchor?.constant = 16
        }
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .beginFromCurrentState, animations:{self.view.layoutIfNeeded()}, completion: nil)
    }
    
    private func moveControlConstraintsOffScreen() {
        pageControlBottomAnchor?.constant = 60
        skipButtomTopAnchor?.constant = -80
        nextButtomTopAnchor?.constant = -80
    }
    
    private func registerCell() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId" )
        collectionView.register(SignInVC.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        
        collectionView.anchorToTop(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func configurePageController() {
        view.addSubview(pageControl)
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = self.pages.count + 1
        pageControl.currentPageIndicatorTintColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
        
        pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)[1]
    }
    
    func configureSkipButton() {
        view.addSubview(skipButton)
        skipButton.setTitle("Atla", for: .normal)
        skipButton.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        skipButton.addTarget(self, action: #selector(skip), for: .touchUpInside)
        
        skipButtomTopAnchor = skipButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
    }
    
    @objc func skip() {
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
    func configureNextButton() {
        view.addSubview(nextButton)
        nextButton.setTitle("İleri", for: .normal)
        nextButton.setTitleColor(UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1), for: .normal)
        nextButton.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        nextButtomTopAnchor = nextButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
    }
    
    @objc func nextPage() {
        if pageControl.currentPage == pages.count {
            return
        }
        
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOffScreen()
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .beginFromCurrentState, animations:{self.view.layoutIfNeeded()}, completion: nil)
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath)
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
            let page = pages[indexPath.item]
            cell.page = page
        
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
