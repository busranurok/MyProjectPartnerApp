//
//  PageCell.swift
//  SupportManagementApp
//
//  Created by HBO on 19.05.2021.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    let pageImageView = UIImageView()
    let pageTextField = UITextView()
    let lineSeparatorView = UIView()
    
    var page : Page? {
        didSet {
            
            guard let page = page else {
                return
            }
            
            pageImageView.image = UIImage(named: page.imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor: color])
            
            attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: color]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.count
            attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
            
            pageTextField.attributedText = attributedText
            
    }
}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLogoImageView()
        configurePageTextField()
        configureLineSeparatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureLogoImageView() {
        addSubview(pageImageView)
        pageImageView.backgroundColor = .systemYellow
        pageImageView.contentMode = .scaleAspectFill
        pageImageView.image = UIImage(named: "page1")
        pageImageView.clipsToBounds = true
        
        pageImageView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    func configurePageTextField() {
        addSubview(pageTextField)
        pageTextField.isEditable = false
        pageTextField.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        
        pageTextField.anchorWithConstantsToTop(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        pageTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
    }
    
    func configureLineSeparatorView() {
        addSubview(lineSeparatorView)
        
        lineSeparatorView.anchorToTop(top: nil, left: leftAnchor, bottom: pageTextField.topAnchor, right: rightAnchor)
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
