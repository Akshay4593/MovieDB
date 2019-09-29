//
//  SNEmptyStateView.swift
//  MovieDB
//
//  Created by Akshay Shedge on 29/09/19.
//  Copyright © 2019 Akshay Shedge. All rights reserved.
//

import Foundation
import UIKit

class SNEmptyStateTheme {
    
    private(set) var titleLabelFont: UIFont = UIFont.themeRegularFont(of: 17)
    private(set) var descLabelFont: UIFont = UIFont.themeRegularFont(of: 15)
    private(set) var retryBtnFont: UIFont = UIFont.themeMediumFont(of: 18)
    
    private(set) var retryBtnBackgroundColor: UIColor = UIColor.red
    private(set) var retryBtnTextColor: UIColor = UIColor.white
    private(set) var titleTextColor: UIColor =  UIColor.gray
    private(set) var descTextColor: UIColor =  UIColor.gray
    private(set) var backgroundColor: UIColor = UIColor.white
    private(set) var roudedCorner: Bool = true
    
    private init() {}
    
    public static let shared = SNEmptyStateTheme()
    
    public class Builder {
        private var theme = SNEmptyStateTheme()
        
        func titleFont(font: UIFont) -> Self {
            theme.titleLabelFont = font
            return self
        }
        
        func descFont(font: UIFont) -> Self {
            theme.descLabelFont = font
            return self
        }
        
        func retryBtnFont(font: UIFont) -> Self {
            theme.retryBtnFont = font
            return self
        }
        
        func backgroundColor(color: UIColor) -> Self {
            theme.backgroundColor = color
            return self
        }
        
        func titleTextColor(color: UIColor) -> Self {
            theme.titleTextColor = color
            return self
        }
        
        func descTextColor(color: UIColor) -> Self {
            theme.descTextColor = color
            return self
        }
        
        func retryBtnBackgroundColor(color: UIColor) -> Self {
            theme.retryBtnBackgroundColor = color
            return self
        }
        
        func retryBtnTextColor(color: UIColor) -> Self {
            theme.retryBtnTextColor = color
            return self
        }
        
        func corners(rounded: Bool) -> Self {
            theme.roudedCorner = rounded
            return self
        }
        
        func build() -> SNEmptyStateTheme {
            return theme
        }
    }
    
}

protocol SNEmptyStateViewDelegate: class {
    func retryBtnTapped()
}

class SNEmptyStateView: UIView {
    
    private weak var delegate: SNEmptyStateViewDelegate?
    private var theme: SNEmptyStateTheme = SNEmptyStateTheme.shared
    
    private var emptyImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private var emptyImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var retryBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleForAllStates("Retry")
        btn.contentEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        return btn
    }()
    
    private var actionBtnContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        setTheme()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addView() {
        emptyImageContainer.setSubviewForAutoLayout(emptyImageView)
        actionBtnContainer.setSubviewForAutoLayout(retryBtn)
        let stackView = UIStackView(arrangedSubviews: [emptyImageContainer, titleLabel, descriptionLabel, actionBtnContainer])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        self.setSubviewForAutoLayout(stackView)
        
        NSLayoutConstraint.activate([
            emptyImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6, constant: 1),
            emptyImageView.heightAnchor.constraint(equalTo: emptyImageView.widthAnchor),
            emptyImageView.topAnchor.constraint(equalTo: emptyImageContainer.topAnchor),
            emptyImageView.bottomAnchor.constraint(equalTo: emptyImageContainer.bottomAnchor),
            emptyImageView.centerXAnchor.constraint(equalTo: emptyImageContainer.centerXAnchor),
            
            retryBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5, constant: 1),
            retryBtn.topAnchor.constraint(equalTo: actionBtnContainer.topAnchor, constant: 15),
            retryBtn.bottomAnchor.constraint(equalTo: actionBtnContainer.bottomAnchor),
            retryBtn.centerXAnchor.constraint(equalTo: actionBtnContainer.centerXAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
    }
    
    private func setTheme() {
        apply(theme: self.theme)
    }
    
    private func configure() {
        retryBtn.isHidden = true
        retryBtn.addTarget(self, action: #selector(retryBtnTapped), for: .touchUpInside)
    }
    
    @objc private func retryBtnTapped() {
        delegate?.retryBtnTapped()
    }
    
    public func apply(theme: SNEmptyStateTheme) {
        self.theme = theme
        self.backgroundColor = theme.backgroundColor
        
        titleLabel.font = theme.titleLabelFont
        titleLabel.textColor = theme.titleTextColor
        
        descriptionLabel.font = theme.descLabelFont
        descriptionLabel.textColor = theme.descTextColor
        
        retryBtn.backgroundColor = theme.retryBtnBackgroundColor
        // retryBtn.setTitleColorForAllStates(theme.retryBtnTextColor)
        retryBtn.titleLabel?.font = theme.retryBtnFont
    }
    
    @available(iOSApplicationExtension, unavailable, message: "This method is NS_EXTENSION_UNAVAILABLE.")
    func show() {
        let keyWindow = UIApplication.value(forKeyPath: #keyPath(UIApplication.shared.keyWindow))
        show(superview: keyWindow as? UIWindow)
    }
    
    public func delegate(with delegate: SNEmptyStateViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    public func with(title: String?, subTitle: String? = nil, image: UIImage? = nil) -> Self {
        emptyImageView.image = image
        titleLabel.text = title
        descriptionLabel.text = subTitle
        emptyImageContainer.isHidden = image == nil
        descriptionLabel.isHidden = subTitle == nil
        titleLabel.isHidden = title == nil
        return self
    }
    
    override func layoutSubviews() {
        // retryBtn.roundCorners(.allCorners, radius: self.theme.roudedCorner ?  retryBtn.frame.height/2 : 0)
    }
    
    public func action(btn retry: String? = nil) -> Self {
        if retry != nil {
            retryBtn.isHidden = false
            retryBtn.setTitleForAllStates(retry!)
        } else {
            retryBtn.isHidden = true
        }
        return self
    }
    
    public func show(superview: UIView!) {
        self.frame = superview.bounds
        superview.addSubview(self)
        superview.bringSubviewToFront(self)
    }
    
    public func hide() {
        if self.superview != nil {
            self.removeFromSuperview()
        }
    }
    
}
